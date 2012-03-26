require 'parse_page'
class HcitController < ApplicationController
  def index
  end

  def submit_link
    @url = params[:u]
    @linked_clothing_item = LinkedClothingItem.by_url(@url).first
   end
  
  def getid
    render :text => "#{params[:callback]}({});" and return
  end
  
  def get_page_details
    url = params[:u]
    @item_properties = parse_page(url)
    
    respond_to do |wants|
      wants.html do
        render :text => "JSON only"
      end
      wants.json { render json: @item_properties.to_json } 
    end
  end
  
  private
  def parse_page(url)
    parser=Parse::Ecommerce::Page.new
    parser.parse_page(url)
  end
end
