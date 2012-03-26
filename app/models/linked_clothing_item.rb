# == Schema Information
#
# Table name: linked_clothing_items
#
#  id       :integer         not null, primary key
#  item_url :string(255)     not null
#

class LinkedClothingItem < ActiveRecord::Base
  child_of "ClothingItem"
  attr_accessible :item_url, :name, :price, :description, :imageurl, :currency
  
  ##Heritage gem hacks, why I'm not sure
  before_create :generate_created_at
  before_save :change_updated_at
  
  scope :by_url, lambda {|url| where("item_url = ?", url).includes(:predecessor)} 
  
  private
  
  def generate_created_at
    self.created_at = DateTime.now
  end
  
  def change_updated_at
    self.updated_at = DateTime.now
  end
end
