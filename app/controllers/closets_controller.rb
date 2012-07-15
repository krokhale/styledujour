load 'lib/backbone_responses.rb'
class ClosetsController < InheritedResources::Base
    belongs_to_subjects

	load_and_authorize_resource :find_by=>:find_by_slug, :except=>[:index]
	#include BackboneResponses
	respond_to :html, :js, :json

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :back, :alert => exception.message
  end



protected

end
