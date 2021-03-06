class FacebookAppController < ApplicationController
  
  before_filter :facebook_session
  
  def index

    # uri = URI.parse("https://graph.facebook.com/")
    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    fb = FbGraph::User.me(@facebook_session_data["oauth_token"])
    fb_user = fb.fetch


    @user = User.find_or_create_for_facebook_oauth({"provider"=>"facebook","uid"=>fb_user.raw_attributes["id"], "info"=>fb_user.raw_attributes},current_user)
    if @user.persisted?
      sign_in @user, :event => :authentication
    end
    #get all app requests
    app_requests = fb_user.app_requests
    clothing_item = nil

    if !app_requests.empty?
      app_requests.each do |request| #each app request
        inviter = Authentication.where(:provider=>"facebook",:uid=>request.from.identifier).first.try(:user_id)
        if inviter
          fb_invite = FacebookUserClothingInvite.by_facebook(request.to.identifier).where(:user_id =>inviter).first
          if fb_invite
            fb_invite.update_attribute(:accepted,true)
            clothing_item = fb_invite.clothing_item_id
            @user.create_friendship(fb_invite.user) ## bond users to a friendship
            fb_invite.user.create_friendship(@user)
          else
            friend = User.find(inviter)
            @user.create_friendship(friend)
            friend.create_friendship(@user)
          end
        end

        #tell facebook to delete app request
        FbGraph::AppRequest.new(request.identifier, :access_token => fb.access_token).destroy
        #request = Net::Http::Delete.new("#{request.identifier}?access_token=#{fb_user.access_token}")
        #response = http.request(request)
      end
      
    end

    

    if clothing_item
      redirect_to clothing_item_path(clothing_item)
    end
  end
  
  private
  def facebook_session
    if params[:signed_request]
     @facebook_session_data = decode_data params[:signed_request]
   else
    @facebook_session_data = []
   end
    #logger.debug @facebook_session_data
  end
  
  def base64_url_decode str
    encoded_str = str.gsub('-','+').gsub('_','/')
    encoded_str += '=' while !(encoded_str.size % 4).zero?
    Base64.decode64(encoded_str)
  end
  
  def decode_data str
    if str
      encoded_sig, payload = str.split('.')
      data = ActiveSupport::JSON.decode base64_url_decode(payload)
    end
  end
end
