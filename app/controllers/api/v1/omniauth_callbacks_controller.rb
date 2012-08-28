class Api::V1::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook

    
    # authenticator ||= Mogli::Authenticator.new("2355533850", "818a52855bed95cb433ab97435a2212f", "") 
    #fb = Mogli::User.find("me", Mogli::Client.create_from_code_and_authenticator(params[:code],authenticator))
    fb = FbGraph::User.me(params[:token])
    fb_user = fb.fetch
    Rails.logger.info "FB: #{fb}" 

    @user = User.find_or_create_for_facebook_oauth({"provider"=>"facebook","uid"=>fb_user.raw_attributes["id"], "info"=>fb_user.raw_attributes},current_user)

    if @user.persisted?
      sign_in @user, :event => :authentication
    end

    respond_to do |format|
      if user
        user.reset_authentication_token!
        format.mobile { render :json=>user.to_json(:methods=>[:authentication_token,:display_name]), :callback => params[:callback]}
        format.json { render :json=>user.to_json(:methods=>[:authentication_token,:display_name]), :callback => params[:callback]}
      else
        format.mobile { render :json=> {:error=>"invalid grant"},status: :unprocessable_entity }
        format.json { render :json=>{:error=>"invalid grant"}, status: :unprocessable_entity }
      end
    end
  end


end