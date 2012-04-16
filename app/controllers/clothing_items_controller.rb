class ClothingItemsController < ApplicationController
  before_filter :get_clothing_item, :except=>[:index,:new,:create]
  before_filter :check_if_scored, :only=>[:show,:hcit_form, :hcit_score]
  before_filter :authenticate_user!, :only=>[:create, :hcit_form, :hcit_score]
  def index
    @clothing_items = ClothingItem.all
  end

  def show
    @already_asked_item = false
    if current_user && !current_user.hcit_items.where(:id=>@clothing_item).empty?
      @already_asked_item = true 
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
# 
  # def edit
# 
  # end
# 
  # def update
# 
    # if @clothing_item.update_attributes(params[:clothing_item])
      # redirect_to @clothing_item, :notice  => "Successfully updated clothing item."
    # else
      # render :action => 'edit'
    # end
  # end
# 
  # def destroy
# 
    # @clothing_item.destroy
    # redirect_to clothing_items_url, :notice => "Successfully destroyed clothing item."
  # end
  
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
  
end
