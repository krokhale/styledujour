class OutfitsController < InheritedResources::Base
	load_and_authorize_resource :find_by=>:find_by_slug, :except=>[:index] ## ADD MORE SECURITY
	belongs_to :closet
	respond_to :html, :js, :json

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :back, :alert => exception.message
  end

  
end
