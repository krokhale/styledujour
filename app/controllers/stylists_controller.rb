class StylistsController < InheritedResources::Base
	
	respond_to :html, :json

	def index
	  index! do |format|
	    format.html
	    format.json do
	      render :json => collection.to_json(:except=>[:created_at,:updated_at,:actor_id], :methods=>[:name])
	    end
	  end
	end
end
