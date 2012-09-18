class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  ##FROM SOCIAL_STREAM
   def facebook
    #render :text => token = request.env['omniauth.auth']['credentials']['token'] and return
    @user = User.find_or_create_for_facebook_oauth(env['omniauth.auth'],current_user)

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
    end
  end
  # def facebook
    # @user = User.find_for_facebook_oauth(request.env['omniauth.auth'], current_user)
#     
    # if @user.persisted?
      # flash[:notice] = "Sucessfully logged in."
      # sign_in_and_redirect @user, :event => :authentication
    # else
      # session["devise.facebook_data"] = request.env["omniauth.auth"]
      # redirect_to new_user_registration_url
    # end
  # end
end