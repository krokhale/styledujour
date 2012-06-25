# == Schema Information
#
# Table name: affiliate_clothing_items
#
#  id                   :integer         not null, primary key
#  activity_object_id   :integer
#  item_url             :string(255)
#  mpn                  :string(255)
#  upc                  :string(255)
#  sku                  :string(255)
#  is_accessory         :boolean
#  skimlinks_product_id :string(255)
#  skimlinks_group_id   :integer
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#

class AffiliateClothingItem < ActiveRecord::Base
  include SocialStream::Models::Object

  child_of "ClothingItem"
  attr_accessible :item_url, :name, :price, :description, :imageurl, :currency, 
    :skimlinks_product_id, :gender, :category, :category_id, :sku, :mpn, :upc, :is_accessory, :skimlinks_group_id,
    :manufacturer, :manufacturer_id, :author_id, :user_author_id, :owner_id, :activity_object_id
  accepts_nested_attributes_for :predecessor
  
  ##Heritage gem hacks, why I'm not sure
  before_create :generate_created_at
  before_save :change_updated_at
  before_create :create_post_activity
  
  scope :by_url, lambda {|url| where("item_url = ?", url).includes(:predecessor)} 
  scope :by_skimlinks, lambda {|id| where("skimlinks_product_id = ?", id)}
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
  

end
