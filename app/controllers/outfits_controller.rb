class OutfitsController < InheritedResources::Base
	load_and_authorize_resource :find_by=>:find_by_slug, :except=>[:index] ## ADD MORE SECURITY
	belongs_to :closet
	respond_to :html, :js, :json

  rescue_from CanCan::AccessDenied do |exception|
  	Rails.logger.warn(exception.message)
    redirect_to :back, :alert => exception.message
  end
	before_filter :set_author_ids, :only => [ :new, :create, :update ]

  after_filter :increment_visit_count, :only => :show
  
  def create
  	@outfit = Outfit.new(params[:outfit])	
  	@outfit.author_id = current_subject.try(:actor_id)
  	@outfit.user_author_id = current_subject.try(:actor_id)
  	@outfit.owner_id = current_subject.try(:actor_id)
  	create!
  end

  def index
	index! do |format|
	  format.html
	  format.js
	  format.json do
	  	render :json => collection.to_json(:only=>[:id,:name,:closet_id,:created_at,:updated_at,:info], :methods=>[:image])
	  end
	end  	
  end

  def show
	show! do |format|
	  format.html
	  format.js
	  format.json do
	  	render :json => resource.to_json(:only=>[:id,:name,:closet_id,:created_at,:updated_at,:info], :methods=>[:image])
	  end
	end  	
  end

  private
    def increment_visit_count
    resource.activity_object.increment!(:visit_count) if request.format == 'html'
  end

  def set_author_ids
  	params[:outfit][:author_id] = current_subject.try(:actor_id)
  	params[:outfit][:user_author_id] = current_subject.try(:actor_id)
  	params[:outfit][:owner_id] = current_subject.try(:actor_id)
    resource_params.first[:author_id] = current_subject.try(:actor_id)
    resource_params.first[:user_author_id] = current_subject.try(:actor_id)
    resource_params.first[:owner_id] = current_subject.try(:actor_id)
  end
end
