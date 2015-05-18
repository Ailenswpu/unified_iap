require "unified_iap/version"
require "unified_iap/googleplay_iap"
require "unified_iap/android_amazon_iap"
require "unified_iap/ios_iap"
require "unified_iap/amazon_client"
require "unified_iap/amazon_result"
require "unified_iap/amazon_exceptions"
require "google/api_client"
require "venice"

module UnifiedIap
  class InvalidParamsException < Exception;end
  
  def self.verify(iap_params, platform_account_secret)
    raise "must provide platform" unless platform
    if iap_params.has_key?(:receipt)
      IosIap.new.verify(iap_params)
    elsif iap_params.has_key?(:package_name)
      GoogleplayIap.new(platform_account_secret).verify(iap_params)
    elsif iap_params.has_key?(:amazon_user_id)
      AndroidAmazonIap.new(platform_account_secret).verify(iap_params)
    else
      raise InvalidParamsException
    end
  end
end
