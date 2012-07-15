# == Schema Information
#
# Table name: user_scored_clothing_items
#
#  user_id          :integer         not null
#  clothing_item_id :integer         not null
#  price            :decimal(, )
#  love             :boolean
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

class UserScoredClothingItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :clothing_item
  
  scope :shopped, where(:love=>true)
  scope :dropped, where(:love=>false)
  
  after_create :update_clothing_item_activity

  def overall_score
    self.clothing_item.overall_hcit_score
  end
  
  private
  
  def update_clothing_item_activity
    verb = love ? "shop" : "drop"
    self.clothing_item.create_scored_activity(verb, self.user)
  end
end
