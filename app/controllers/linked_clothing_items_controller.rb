class LinkedClothingItemsController < ApplicationController
  #include SocialStream::Controllers::Objects
  after_filter :increment_visit_count, :only => :show
  before_filter :authenticate_user!, :only=>[:new,:create,:invite_friends]
 rescue_from CanCan::AccessDenied do |exception|
    render :action => 'new', :alert => exception.message
  end
  
  def destroy
    @post_activity = resource.post_activity
  
    destroy!
  end
  


  before_filter :set_author_ids, :only => [ :new, :create, :update ]

  after_filter :increment_visit_count, :only => :show

  load_and_authorize_resource :except => [:index, :invite_friends]

  respond_to :html, :js


  def index
    # @linked_clothing_items = LinkedClothingItem.all
    redirect_to clothing_items_url
  end

  def show
    @linked_clothing_item = LinkedClothingItem.find(params[:id])
  end

  def new
    @linked_clothing_item = LinkedClothingItem.new
  end

  def create
    @linked_clothing_item = LinkedClothingItem.new(params[:linked_clothing_item])
    @linked_clothing_item.set_ownership(current_user.id,current_subject.try(:actor_id), current_user.try(:actor_id))

    @linked_clothing_item._relation_ids = Array.wrap Relation::Public.instance.id #forcing this to be a public object
    if @linked_clothing_item.save
      unless current_user.hcit_items.where("user_asked_clothing_items.clothing_item_id = ?",@linked_clothing_item).first
        current_user.hcit_items << @linked_clothing_item.predecessor 
      end
      redirect_to invite_friends_linked_clothing_item_url(@linked_clothing_item), :success => "Successfully created!"
    else
      render :action => 'new'
    end
  end

  def edit
    @linked_clothing_item = LinkedClothingItem.find(params[:id])
  end

  def update
    @linked_clothing_item = LinkedClothingItem.find(params[:id])
    if @linked_clothing_item.update_attributes(params[:linked_clothing_item])
      redirect_to @linked_clothing_item, :notice  => "Successfully updated linked clothing item."
    else
      render :action => 'edit'
    end
  end

  def destroy
    # @linked_clothing_item = LinkedClothingItem.find(params[:id])
    # @linked_clothing_item.destroy
    redirect_to clothing_items_url, :notice => "Successfully destroyed linked clothing item."
  end
  
  def invite_friends
    @linked_clothing_item = LinkedClothingItem.find(params[:id])
  end
  
  def confirmation
    @linked_clothing_item = LinkedClothingItem.find(params[:id])
  end
  
  
  protected

  def increment_visit_count
    resource.activity_object.increment!(:visit_count) if request.format == 'html'
  end

  def set_author_ids
    params[:linked_clothing_item][:author_id] = current_subject.try(:actor_id)
    params[:linked_clothing_item][:user_author_id] = current_user.try(:actor_id)
  end
end
