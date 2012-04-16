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
end
