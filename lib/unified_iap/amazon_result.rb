module UnifiedIap
  class AmazonResult
    attr_accessor :item_type, :sku, :start_date, :start_time, :end_date, :end_time, :purchase_token

    def initialize(response)
      case response.code.to_i
      when 200
        parsed = JSON.parse(response.body)

        if parsed.has_key? 'startDate'
          parsed['startTime'] = parsed['startDate'].nil? ? nil : Time.at(parsed['startDate'] / 1000)
        end
        if parsed.has_key? 'endDate'
          parsed['endTime'] = parsed['endDate'].nil? ? nil : Time.at(parsed['endDate'] / 1000)
        end

        parsed.each do |key, value|
          underscore = key.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').gsub(/([a-z\d])([A-Z])/, '\1_\2').tr('-', '_').downcase
          send "#{underscore}=", value
        end
      when 400 then raise UnifiedIap::AmazonExceptions::InvalidTransaction
      when 496 then raise UnifiedIap::AmazonExceptions::InvalidSharedSecret
      when 497 then raise UnifiedIap::AmazonExceptions::InvalidUserId
      when 498 then raise UnifiedIap::AmazonExceptions::InvalidPurchaseToken
      when 499 then raise UnifiedIap::AmazonExceptions::ExpiredCredentials
      when 500 then raise UnifiedIap::AmazonExceptions::InternalError
      else raise UnifiedIap::AmazonExceptions::General
      end
    end
  end
end
