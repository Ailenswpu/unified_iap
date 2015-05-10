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

  def self.verify(platform, platform_account_secret, iap_params)
    raise "must provide platform" unless platform
    if platform == "IOS"
      IosIap.new.verify(iap_params)
    elsif platform == "ANDROID_GP"
      GoogleplayIap.new(platform_account_secret).verify(iap_params)
    elsif platform == "AMAZON"
      AndroidAmazonIap.new(platform_account_secret).verify(iap_params)
    else
      raise "unsupport platform"
    end
  end

end
