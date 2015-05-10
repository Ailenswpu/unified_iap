module UnifiedIap
  class AndroidAmazonIap
    def initialize(amazon_secret_key)
      raise "amazon_secret_key must exsist" unless amazon_secret_key
      @client ||= UnifiedIap::AmazonClient.new amazon_secret_key#, "http://localhost:8080/RVSSandbox"
    end

    def verify(amazon_iap_params = {})
      begin
        @client.verify amazon_iap_params[:amazon_user_id], amazon_iap_params[:purchase_token]
      rescue UnifiedIap::AmazonExceptions::Exception => e
        raise e
      end
    end
  end
end
