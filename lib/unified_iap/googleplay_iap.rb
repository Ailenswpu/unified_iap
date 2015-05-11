module UnifiedIap

  class NoApiVersionException          < Exception;end
  class NoServiceAccountEmailException < Exception;end
  class NoKeyFileException             < Exception;end
  class NoDeveloperEmailException      < Exception;end

  class GoogleplayIap
    def verify(googleplay_iap_params = {})
      publisher = client.discovered_api('androidpublisher', 'v1.1')
      client.execute(
      api_method: publisher.inapppurchases.get, 
      parameters: { packageName: googleplay_iap_params[:package_name],
        productId: googleplay_iap_params[:product_id],
        token: googleplay_iap_params[:purchase_token]}).data
    end

    def initialize(params = {})
      @api_version = params[:api_version] || (raise NoApiVersionException)
      @service_account_email = params[:service_account_email] || (raise NoServiceAccountEmailException)
      @key_file = params[:key_file] || (raise NoKeyFileException)
      @key_secret = params[:key_secret] || 'notasecret'
      @scope_url = params[:scope_url] || 'https://www.googleapis.com/auth/androidpublisher'
      @token_credential_uri = params[:token_credential_uri] || 'https://accounts.google.com/o/oauth2/token'
      @audience = params[:audience] || 'https://accounts.google.com/o/oauth2/token'
      @person = params[:person] || (raise NoDeveloperEmailException)
    end

    def client
      @client  ||= init_googleplay_api_client
    end

    def init_googleplay_api_client
      client = Google::APIClient.new(application_name: 'Ruby Inapppurchases verify', application_version: @api_version)

      client.authorization = Signet::OAuth2::Client.new(
        token_credential_uri: @token_credential_uri,
        audience: @audience,
        scope: @scope_url,
        issuer: @service_account_email,
        signing_key: Google::APIClient::KeyUtils.load_from_pkcs12(@key_file, @key_secret),
      person: @person)

      client.authorization.fetch_access_token!
      client
    end

  end
end
