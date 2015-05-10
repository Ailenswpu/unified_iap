module UnifiedIap
  class IosIap
    def verify(ios_iap_params = {})
      data = Venice::Receipt.verify(ios_iap_params[:receipt])
    end
  end
end