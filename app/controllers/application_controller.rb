class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to_mobile_requests :fall_back => :html, :skip_xhr_requests => true
  before_filter :check_referral_code
  before_filter :add_abilities
    
  private
  def check_referral_code
    if params[:ref]
      session[:referral] = params[:ref]
    end
  end

  def current_closet
  	current_actor.closet
  end

  def add_abilities
   @current_ability ||=Ability.new(current_subject)

  end
end
