require 'parse_page'
class HcitController < ApplicationController
  before_filter :authenticate_user!, :only=>[:fb_request, :my_asks, :my_scores, :submit_link]
  
  def index
  end

  def submit_link
    @url = params[:u]
    @linked_clothing_item = LinkedClothingItem.by_url(@url).first
    if @linked_clothing_item
    else
      @linked_clothing_item = LinkedClothingItem.new
    end
    
    
   end
  
  def getid
    render :text => "#{params[:callback]}({});" and return
  end
  
  def get_page_details
    url = params[:u]
    @item_properties = parse_page(url)
    @item_properties[:prices].collect! { |x| x.sub("$","")}
    respond_to do |wants|
      wants.html do
        render :text => "JSON only"
      end
      wants.json { render json: @item_properties } 
    end
  end
  
  def fb_request
    @clothing_item = ClothingItem.find(params[:clothing_item_id])
    @fb_ids = params[:fb_ids]
    result = nil #flawed: fails to pick up additional invite errors
    if @clothing_item && current_user
      @fb_ids.each do |fbid|
        if fbid.to_i > 0
          existing_fb_invite = FacebookUserClothingInvite.where(:user_id=>current_user, :facebook_id=>fbid.to_i).first
          if !existing_fb_invite
            invite = FacebookUserClothingInvite.new
            invite.user = current_user
            invite.clothing_item = @clothing_item
            invite.facebook_id = fbid.to_i
            result= invite.save
          else
            result = true #already exists
          end
        end
      end
    end  
    
    respond_to do |wants|
      wants.html do
        if result
          redirect_to clothing_item_path(@clothing_item), :notice => "You successfully asked your friends!"
        else
          redirect_to clothing_item_path(@clothing_item), :error => "We are sorry, something went wrong."
        end
      end
      wants.js do
        if result 
          render :json=> nil, :status => 200 
        else
          render :json=> nil, :status => 500  
        end
      end
    end
  end
  
  
  def my_asks
    @clothing_items = current_user.hcit_items.order('user_asked_clothing_items.created_at desc').includes(:scores).limit(20)
    respond_to do |wants|
      wants.html {}
      wants.json { render json: @clothing_items.to_json(:except=>[:activity_object_id, :heir_id, :heir_type, :photo_content_type, :photo_file_name, :photo_file_size, :photo_updated_at],
          :methods=>[:photo_url],:include=>[:scores => {:only=>[:clothing_item_id, :love, :price, :user_id], :methods => [:overall_score]},:heir => {:only=>[:item_url]}]), :status => 200 } 
      wants.mobile {render :text => "why are you here?"}
    end
  end
  
  def my_scores
    @clothing_items = current_user.scored_items.order('user_scored_clothing_items.created_at desc').includes(:scores).limit(20)
    respond_to do |wants|
      wants.html {}
      wants.json { render json: @clothing_items.to_json(:except=>[:activity_object_id, :heir_id, :heir_type, :photo_content_type, :photo_file_name, :photo_file_size, :photo_updated_at],
          :methods=>[:photo_url],:include=>[:scores => {:only=>[:clothing_item_id, :love, :price, :user_id], :methods => [:overall_score]},:heir => {:only=>[:item_url]}]), :status => 200  } 
    end
  end
  
  def browse
    @clothing_items = ClothingItem.order("created_at DESC").limit(20)
    respond_to do |wants|
      wants.html do
        
      end
      wants.json { render json: @clothing_items } 
    end
  end
  
  def how_cute
    @points = current_user.points_earned_cache || 0
    @scored = current_user.scored_items.count
    @asks = current_user.hcit_items.count

    respond_to do |wants|
      wants.html {}
      wants.json { render json: {points: @points, scored: @scored, asks: @asks, :status => 200  } }
    end
  end
  
  private
  def parse_page(url)
    parser=Parse::Ecommerce::Page.new
    parser.parse_page(url)
  end
end
