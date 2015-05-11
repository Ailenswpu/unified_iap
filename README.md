# UnifiedIap

UnifiedIap is for mobile game or app developer to verify the accuracy if inapppurchase to prevent hacker. UnifiedIap the main platform:   

* iOS   
* Googleplay  
* Amazon  


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'unified_iap'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install unified_iap

## Usage

### 1.Android Gooleplay
If you apps or games are published to googleplay, see [gp-purchase-status-api](https://developer.android.com/google/play/billing/gp-purchase-status-api.html), to get your `service_account_email`,`p12 key_file`  .

```ruby
     googleplay_account_secret_params = {
        api_version: 'v1.1',
        service_account_email: 'REPLACE YOUR SERVICE ACCOUNT EMAIL',
        key_file: "PATH TO YOUR p12 File",
        key_secret: 'notasecret',
        scope_url: 'https://www.googleapis.com/auth/androidpublisher',
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        audience: 'https://accounts.google.com/o/oauth2/token',
        person: 'YOUR GOOGLEPLAY ACCOUNT EMAIL',
     }
     #do not forget replace service_account_email, key_file, person with your own information.

     googleplay_callback_info  = {
        package_name:  'com.bbg.dw.ww1',
        product_id: 'com.bbg.dw.ww1.60000',
        purchase_token: "dmkgpgikajliabogedjojdak.AO-J1OzEhpio5zq-F-LzuYEMsryAopNT4sdEIUBnSfOja4jgbfAMyOkCtquULWGqKRT_VEnL2V9oCh-cBBPbJp1amuh5CKDzHeVAJFe_VjjvdgngeT8rWRN98SqzOSXCRCWGZSu6KpTR"
      }

      # you can get package_name, product_id, purchase_token from your mobile app googleplay response when you purchase success.

      UnifiedIap.verify("ANDROID_GP", googleplay_account_secret_params, googleplay_callback_info)

      #make sure the constant `ANDROID_GP`.
```
The example return  of valid iap order
```ruby
 #<Google::APIClient::Schema::Androidpublisher::V1_1::InappPurchase:0x3fd7bc6649b8 DATA:{"kind"=>"androidpublisher#inappPurchase", "purchaseTime"=>"1428479533509", "purchaseState"=>1, "consumptionState"=>1, "developerPayload"=>""}>
```

The example return  of invalid iap order

```ruby
<Google::APIClient::Schema::Androidpublisher::V1_1::InappPurchase:0x3fd7bc938f40 DATA:{"error"=>{"errors"=>[{"domain"=>"global", "reason"=>"applicationNotFound", "message"=>"No application was found for the given package name.", "locationType"=>"parameter", "location"=>"packageName"}], "code"=>404, "message"=>"No application was found for the given package name."}}>
```

### 2. iOS
if your apps or games published to AppStore, you only need the response from appstore of user orders.

```ruby
ios_iap_response = {
	receipt: 'IOS RECEIPT OF IAP'
}

UnifiedIap.verify("IOS", nil, ios_iap_response)
```

### 3. Amazon

if your apps or games published to AmazonStore.you need your [secretkey](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSGettingStartedGuide/AWSCredentials.html)

```ruby
amazon_secret = "REPLACE AMAZON SECRET"

amazon_iap_params = {
        amazon_user_id:"REPLACE USER ID", 
        purchase_token: "REPLACE PURCHASE TOKEN"
}

UnifiedIap.verify("AMAZON", amazon_secret, amazon_iap_params)


```

## Contributing

1. Fork it ( https://github.com/Ailenswpu/unified_iap/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
