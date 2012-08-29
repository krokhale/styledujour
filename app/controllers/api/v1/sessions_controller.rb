class Api::V1::SessionsController < Devise::SessionsController
  layout :false

  def get_authentication_token
    respond_to do |format|
      if current_user
        format.mobile { render :json=>current_user.to_json(:methods=>[:authentication_token,:display_name]), :callback => params[:callback]}
        format.json { render :json=>current_user.to_json(:methods=>[:authentication_token,:display_name]), :callback => params[:callback]}
      else
        format.mobile { render :json=> {:error=>"no authentication token"},status: :unauthorized,  :callback => params[:callback] }
        format.json { render :json=>{:error=>"no authentication token"}, status: :unauthorized, :callback => params[:callback] }
      end
    end
  end

  def new
    super
  end

  def create
    user = warden.authenticate(:scope=>:user)
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