# == Schema Information
#
# Table name: user_bookmarked_clothing_items
#
#  user_id          :integer         not null
#  clothing_item_id :integer         not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

class UserBookmarkedClothingItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :clothing_item

  attr_accessible :clothing_item_id
end
