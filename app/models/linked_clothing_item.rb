# == Schema Information
#
# Table name: linked_clothing_items
#
#  id                 :integer         not null, primary key
#  item_url           :string(255)     not null
#  activity_object_id :integer
#

class LinkedClothingItem < ActiveRecord::Base
  include SocialStream::Models::Object

  child_of "ClothingItem"
  attr_accessible :item_url, :name, :price, :description, :imageurl, :currency, :retailer_id, :manufacturer_id
  attr_accessible :author_id, :user_author_id, :owner_id, :activity_object_id
  accepts_nested_attributes_for :predecessor
  ##Heritage gem hacks, why I'm not sure
  before_create :generate_created_at
  before_save :change_updated_at
  before_create :create_post_activity
  after_create :reward_user
  
  scope :by_url, lambda {|url| where("item_url = ?", url).includes(:predecessor)} 

  def set_ownership(owner, author, user_author )
    self.owner= owner
    self.author_id = author
    self.user_author_id = user_author
    self.predecessor.owner = owner
    self.predecessor.author_id = author
    self.predecessor.user_author_id = user_author
  end
  private
  
  def generate_created_at
    self.created_at = DateTime.now
  end
  
  def change_updated_at
    self.updated_at = DateTime.now
  end

  def create_post_activity
    logger.debug "verb hello"  #want to skip this for double entry
  end
  
  def reward_user
    
    Point.award(self.user_author.user, "HCIT_add_clothing_item")
  end
end
