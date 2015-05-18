require 'spec_helper'

describe 'UnifiedIap' do
  describe "#verify" do

    let(:iap_params) do
      {
        package_name:  'com.bbg.dw.ww1',
        product_id: 'com.bbg.dw.ww1.60000',
        purchase_token: "dmkgpgikajliabogedjojdak.AO-J1OzEhpio5zq-F-LzuYEMsryAopNT4sdEIUBnSfOja4jgbfAMyOkCtquULWGqKRT_VEnL2V9oCh-cBBPbJp1amuh5CKDzHeVAJFe_VjjvdgngeT8rWRN98SqzOSXCRCWGZSu6KpTR"
      }
    end

    let(:googleplay_account_secret_params) do
      {
        api_version: 'v1.1',
        service_account_email: 'REPLACE YOUR SERVICE ACCOUNT EMAIL',
        key_file: "PATH TO YOUR p12 File",
        key_secret: 'notasecret',
        scope_url: 'https://www.googleapis.com/auth/androidpublisher',
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        audience: 'https://accounts.google.com/o/oauth2/token',
        person: 'YOUR GOOGLEPLAY ACCOUNT EMAIL',
      }
    end

    let (:amazon_iap_params) do
      {
        amazon_user_id:"tfzqEZANv3rrrvQsLAjDtWjTZ-7INPv54GyJzrWdH1Q=", 
        purchase_token: "2:I3YhwaI6ICNNnt_FTCylN9dhlghTyItfuMbGzH8dVvQih7AT_pl-fP3vLDcRbPTGEAdiWrU2rztBVPktNrU0NXg1G6wMf1YscKbQmGo447RoS8IVfeJU-3cX8_yYxG6TThhzNxI_-QdVU1IsloMewhKQcfuFYTyckkC54VYXyEW_k3yVLtduN-DIc_N7rwr0F58ahfNiCAMkAS3aDxjtHVRE2NI8ALajaIZqk4sv228QOPxkp_a_Z_g27XX7t8o0_O-OgZo0XTYKJlcUn38ozfEuWpNfH82Gzv-267faw9x8rOw07HeLhUCtW5YAwCQW:s0w4JQor7XKkWtVHHHy2nA=="
      }
    end

    let(:amazon_secret) do
      "REPLACE YOUR AMAZON SECRET"
    end

    it "verify gp success" do
      expect(UnifiedIap.verify(iap_params, googleplay_account_secret_params)['error']).to be_nil
    end

    it "verify amazon" do
      expect(UnifiedIap.verify(amazon_iap_params, amazon_secret)).to_not be_nil
    end

  end
end
