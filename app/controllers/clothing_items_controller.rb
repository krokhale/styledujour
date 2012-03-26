class ClothingItemsController < ApplicationController
  def index
    @clothing_items = ClothingItem.all
  end

  def show
    @clothing_item = ClothingItem.find(params[:id])
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
    @clothing_item = ClothingItem.find(params[:id])
  end

  def update
    @clothing_item = ClothingItem.find(params[:id])
    if @clothing_item.update_attributes(params[:clothing_item])
      redirect_to @clothing_item, :notice  => "Successfully updated clothing item."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @clothing_item = ClothingItem.find(params[:id])
    @clothing_item.destroy
    redirect_to clothing_items_url, :notice => "Successfully destroyed clothing item."
  end
  
end
