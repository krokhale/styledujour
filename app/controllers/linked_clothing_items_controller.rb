class LinkedClothingItemsController < ApplicationController
  before_filter :authenticate_user!, :only=>[:new,:create,:invite_friends]
  
  def index
    @linked_clothing_items = LinkedClothingItem.all
  end

  def show
    @linked_clothing_item = LinkedClothingItem.find(params[:id])
  end

  def new
    @linked_clothing_item = LinkedClothingItem.new
  end

  def create
    @linked_clothing_item = LinkedClothingItem.new(params[:linked_clothing_item])
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
    @linked_clothing_item = LinkedClothingItem.find(params[:id])
    @linked_clothing_item.destroy
    redirect_to linked_clothing_items_url, :notice => "Successfully destroyed linked clothing item."
  end
  
  def invite_friends
    @linked_clothing_item = LinkedClothingItem.find(params[:id])
  end
  
  def confirmation
    @linked_clothing_item = LinkedClothingItem.find(params[:id])
  end
end
