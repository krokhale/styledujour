class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to_mobile_requests :fall_back => :html, :skip_xhr_requests => false
  before_filter :check_referral_code
  
  private
  def check_referral_code
    if params[:ref]
      session[:referral] = params[:ref]
    end
  end
end
