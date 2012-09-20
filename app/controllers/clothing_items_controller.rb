load 'lib/backbone_responses.rb'
class ClothingItemsController < ApplicationController
  #include SocialStream::Controllers::Objects #HAVE TO OVERRIDE
  skip_before_filter :verify_authenticity_token

  before_filter :get_clothing_item, :except=>[:index,:new,:create, :bookmarked]
  before_filter :check_if_scored, :only=>[:show,:hcit_form, :hcit_score]
  before_filter :authenticate_user!, :only=>[:create, :hcit_form, :bookmark, :bookmarked]
  include BackboneResponses

  def destroy
    @post_activity = resource.post_activity

    destroy!
  end
  inherit_resources

  before_filter :set_author_ids, :only => [ :new, :create, :update ]

  after_filter :increment_visit_count, :only => :show

  load_and_authorize_resource :except => [:index, :hcit_form, :hcit_score, :invite_friends, :user_scored_clothing_item, :add_to_closet, :bookmark, :bookmarked]

  respond_to :html, :js, :json

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access Denied!"
    Rails.logger.debug "#{exception.message}"
    redirect_to :back, :alert => exception.message
  end

  has_scope :public, :type=>:boolean, :default=>true, :only=>[:index]
  def index
    
    collection_public_attributes
    # if params[:closet_id] #support nested resources
    #   @clothing_items = current_closet.clothing_items
    # else
    #   @clothing_items = ClothingItem.limit(10)
    # end

    respond_to do |wants|
       wants.html do

       end

        wants.js do
           render :json=> nil, :status => 500
        end

        wants.json do
          render :json=>@clothing_items.to_json(:except=>[:activity_object_id, :heir_id, :heir_type, :photo_content_type, :photo_file_name, :photo_file_size, :photo_updated_at],
          :methods=>[:photo_url],:include=>[:heir => {:only=>[:item_url]}]), :status => 200
        end
     end
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
    if @clothing_item.overall_hcit_score
      @buy_it = (@clothing_item.price < BigDecimal.new(@clothing_item.overall_hcit_score)) ? "btn-success" : "btn-warning"
    else
      @buy_it = "btn-success"
    end

    respond_to do |wants|
       wants.html do
         #redirect_to clothing_item_path(@clothing_item)
       end

      wants.json do
         render :json=>@clothing_item.to_json(:include=>[:heir])
      end
     end
  end

  def new
    @clothing_item = ClothingItem.new
  end

  def create
    @clothing_item = ClothingItem.new(params[:clothing_item])
    if @clothing_item.save
      respond_to do |format|
        format.html { redirect_to @clothing_item, :notice => "Successfully created clothing item." }
        format.json { render :json => @clothing_item.attributes.merge(:url => @clothing_item.photo.try(:url)).to_json }
      end
    else
      respond_to do |format|
        format.html { render :action => 'new'}
        format.json { render :json => @clothing_item.errors }
      end
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

            wants.json do
              render :json=>{:message => '<h1>We got it! You have earned 1 Style Point.</h1>'}, :status => 200
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

            wants.json do
              render :json=> nil, :status => 500
            end
           end
        end
      else
        respond_to do |wants|
           wants.html do
            redirect_to :hcit_form
           end

          wants.json do
            render :json=> {:message => '<h1>You already scored this item.</h1>'}, :status => 302
          end
         end

      end
    elsif @clothing_item && !current_user
      cookies[:clothing_score] = {:value=>{:item=>@clothing_item.id, :score=>params[:user_scored_clothing_item][:price], :love=>params[:user_scored_clothing_item][:love]}.to_json}
      respond_to do |wants|
        wants.js do

        end

        wants.json do
          render :json=> {:message => "<h3>You must <a href=\"#{new_user_session_path}\">login</a> to save this score!</h3>"}, :status => 302
        end

      end
    end
  end

  def user_scored_clothing_item
    if current_user
      @user_score = UserScoredClothingItem.where(:clothing_item_id => @clothing_item.id, :user_id=>current_user.id).first || UserScoredClothingItem.new(:user=>current_user, :clothing_item=>@clothing_item) unless @user_price
    else
      @user_score = UserScoredClothingItem.new(:clothing_item=>@clothing_item)
    end

    respond_to do |wants|
       wants.html do
         redirect_to clothing_item_path(@clothing_item)
       end

      wants.json do
         render :json=>@user_score.to_json(:only=>[:clothing_item_id, :love, :price, :user_id], :include=>[], :methods => [:overall_score])
      end
     end
  end

  def add_to_closet
    status = 500
    if current_user
      if current_closet.clothing_items.find_by_id(@clothing_item)
        status = 200
      else
        current_closet.clothing_items << @clothing_item
        status = 200
      end
    end
    respond_to do |wants|
      wants.json do
        render :json=>nil, :status=>status
      end
    end
  end

  def bookmark
    status = 500
    if current_user
      if current_user.bookmarks.find_by_id(@clothing_item)
        status = 200
      else
        #current_user.bookmarks << @clothing_item
        item = current_user.user_bookmarked_clothing_items.new
        item.clothing_item = @clothing_item
        current_user.user_bookmarked_clothing_items << item
        #current_user.bookmarks.create!(:clothing_item_id=>@clothing_item)
        status = 200
      end
    end
    respond_to do |wants|
      wants.json do
        render :json=>nil, :status=>status
      end
    end
  end

  def bookmarked
    @bookmarks = current_user.bookmarked_items

    respond_to do |wants|
      wants.json do
        render :json=>@bookmarks, :status=>:success
      end
      wants.html do
      end
    end
  end

  private
  def get_clothing_item
    @clothing_item = ClothingItem.includes(:heir).find(params[:id])
  end

  def check_if_scored
    @already_scored_item = false
    if current_user && !current_user.scored_items.where(:id=>@clothing_item).empty?
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
    if !resource_params.first[:owner_id]
      resource_params.first[:owner_id] = current_subject.try(:actor_id)
    end
  end

  def begin_of_association_chain
    if params[:closet_id]
      current_closet
    else
      super
    end
  end
end

