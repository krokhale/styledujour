# == Schema Information
#
# Table name: clothing_items
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  price           :decimal(8, 2)
#  description     :text
#  imageurl        :string(255)
#  currency        :string(255)
#  retailer_id     :integer
#  manufacturer_id :integer
#  heir_id         :integer
#  heir_type       :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class ClothingItem < ActiveRecord::Base
  parent_model
  attr_accessible :name, :price, :description, :imageurl, :currency, :retailer_id, :manufacturer_id

  
  has_and_belongs_to_many :bookmarkers, :class_name=> "User", :join_table => "user_bookmarked_clothing_items", :foreign_key => "clothing_item_id"   
  has_many :user_asked_clothing_items
  has_many :user_scored_clothing_items
  
  has_many :askers, :through => :user_asked_clothing_items, :class_name => "User", :source=>:user
  has_many :scores, :class_name => "UserScoredClothingItem"
  has_many :scorers, :through => :user_scored_clothing_items, :class_name => "User", :source=>:user
end
