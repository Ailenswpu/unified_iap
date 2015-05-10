module UnifiedIap
  module AmazonExceptions
    class Exception < Exception; end
    class InvalidTransaction < UnifiedIap::AmazonExceptions::Exception; end
    class InvalidSharedSecret < UnifiedIap::AmazonExceptions::Exception; end
    class InvalidUserId < UnifiedIap::AmazonExceptions::Exception; end
    class InvalidPurchaseToken < UnifiedIap::AmazonExceptions::Exception; end
    class ExpiredCredentials < UnifiedIap::AmazonExceptions::Exception; end
    class InternalError < UnifiedIap::AmazonExceptions::Exception; end
    class General < UnifiedIap::AmazonExceptions::Exception; end
  end
end
