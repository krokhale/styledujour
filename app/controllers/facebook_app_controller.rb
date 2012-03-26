class FacebookAppController < ApplicationController
  
  before_filter :facebook_session
  
  def index
    @facebook_session_data["user_id"]
    @facebook_session_data["oauth_token"]
  end
  
  private
  def facebook_session
    @facebook_session_data = decode_data params[:signed_request]
    logger.debug @facebook_session_data
  end
  
  def base64_url_decode str
    encoded_str = str.gsub('-','+').gsub('_','/')
    encoded_str += '=' while !(encoded_str.size % 4).zero?
    Base64.decode64(encoded_str)
  end
  
  def decode_data str
    encoded_sig, payload = str.split('.')
    data = ActiveSupport::JSON.decode base64_url_decode(payload)
  end
end
