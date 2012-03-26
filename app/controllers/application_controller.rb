class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to_mobile_requests :fall_back => :html, :skip_xhr_requests => false
  
end
