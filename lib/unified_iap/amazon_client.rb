module UnifiedIap
  class AmazonClient
    require 'net/http'
    require 'uri'

    PRODUCTION_HOST = 'https://appstore-sdk.amazon.com'

    def initialize(developer_secret, host=nil)
      @developer_secret = developer_secret
      @host = host || PRODUCTION_HOST
    end

    def verify(user_id, purchase_token, renew_on_failure=true)
      begin
        process :verify, user_id, purchase_token
      rescue UnifiedIap::AmazonExceptions::ExpiredCredentials => e
        raise e unless renew_on_failure

        renewal = renew(user_id, purchase_token)
        verify(user_id, renewal.purchase_token, false)
      end
    end

    def renew(user_id, purchase_token)
      process :renew, user_id, purchase_token
    end

    protected

    def process(path, user_id, purchase_token)
      path = "/version/2.0/#{path}/developer/#{@developer_secret}/user/#{user_id}/purchaseToken/#{purchase_token}"
      uri = URI.parse "#{@host}#{path}"
      req = Net::HTTP::Get.new uri.request_uri
      res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request req }
      UnifiedIap::AmazonResult.new res
    end
  end
end
