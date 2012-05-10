class ClothingItemsController < ApplicationController
  #include SocialStream::Controllers::Objects #HAVE TO OVERRIDE
  before_filter :get_clothing_item, :except=>[:index,:new,:create]
  before_filter :check_if_scored, :only=>[:show,:hcit_form, :hcit_score]
  before_filter :authenticate_user!, :only=>[:create, :hcit_form]
  
  def destroy
    @post_activity = resource.post_activity

    destroy!
  end
  inherit_resources

  before_filter :set_author_ids, :only => [ :new, :create, :update ]

  after_filter :increment_visit_count, :only => :show

  load_and_authorize_resource :except => [:index, :hcit_form, :hcit_score, :invite_friends]

  respond_to :html, :js



  def index
    @clothing_items = ClothingItem.all
  end

  def show
    @already_asked_item = false
    if current_user
      if !current_user.hcit_items.where(:id=>@clothing_item).empty?
        @already_asked_item = true 
        
      end
      #@user_price = @clothing_item.score_for(current_user)
      @user_score = UserScoredClothingItem.where(:clothing_item_id => @clothing_item.id, :user_id=>current_user.id).first || UserScoredClothingItem.new(:user=>current_user, :clothing_item=>@clothing_item) unless @user_price
    end
    
  end

  def new
    @clothing_item = ClothingItem.new
  end

  def create
    @clothing_item = ClothingItem.new(params[:clothing_item])
    if @clothing_item.save
      redirect_to @clothing_item, :notice => "Successfully created clothing item."
    else
      render :action => 'new'
    end
  end

  def edit

  end

  def update

    if @clothing_item.update_attributes(params[:clothing_item])
      redirect_to @clothing_item, :notice  => "Successfully updated clothing item."
    else
      render :action => 'edit'
    end
  end

  def destroy

    #@clothing_item.destroy
    redirect_to clothing_items_url, :notice => "Successfully destroyed clothing item."
  end
  
  def hcit_form
    @user_score = UserScoredClothingItem.new(:user=>current_user, :clothing_item=>@clothing_item)
    if request.xhr?
      render :layout=>false and return
    end
  end
  
  def hcit_score

    if current_user && @clothing_item
      if !@already_scored_item
        score = UserScoredClothingItem.new
        score.user = current_user
        score.clothing_item = @clothing_item
        score.price = params[:user_scored_clothing_item][:price]
        score.love = params[:user_scored_clothing_item][:love]
        
        if score.save
           Point.award(current_user, "HCIT_score_clothing_item")
           respond_to do |wants|
             wants.html do
               redirect_to clothing_item_path(@clothing_item), :notice => "We got how cute you thought it was!"
             end
            
            wants.js do
               
            end
           end
         else
           respond_to do |wants|
             wants.html do
               redirect_to clothing_item_path(@clothing_item), :error => "We couldn't understand how cute you thought it was!"
             end
            
            wants.js do
               render :json=> nil, :status => 500 
            end
           end
        end
      else
        redirect_to :hcit_form
      end
    elsif @clothing_item && !current_user
      cookies[:clothing_score] = {:value=>{:item=>@clothing_item.id, :score=>params[:user_scored_clothing_item][:price], :love=>params[:user_scored_clothing_item][:love]}.to_json}
      respond_to do |wants|
        wants.js do
          
        end
      end
    end
  end
  
  
  private
  def get_clothing_item
    @clothing_item = ClothingItem.find(params[:id])
  end
  
  def check_if_scored
    @already_scored_item = false
    if current_user && !current_user.scorered_items.where(:id=>@clothing_item).empty?
      @already_scored_item = true 
    end
  end
  
  protected

  def increment_visit_count
    resource.activity_object.increment!(:visit_count) if request.format == 'html'
  end

  def set_author_ids
    resource_params.first[:author_id] = current_subject.try(:actor_id)
    resource_params.first[:user_author_id] = current_user.try(:actor_id)
  end
end
