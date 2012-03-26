# == Schema Information
#
# Table name: user_asked_clothing_items
#
#  user_id          :integer         not null
#  clothing_item_id :integer         not null
#  referrer         :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

class UserAskedClothingItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :clothing_item
end
