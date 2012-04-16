# == Schema Information
#
# Table name: facebook_user_clothing_invites
#
#  id               :integer         not null, primary key
#  facebook_id      :integer(8)
#  user_id          :integer
#  clothing_item_id :integer
#  accepted         :boolean
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

class FacebookUserClothingInvite < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :clothing_item
  
  
  scope :by_facebook, lambda{ |id| where(facebook_id: id) unless id.nil?}
  
  scope :by_user, lambda{ |user| where(:user_id=> user) unless user.nil?}
  
end
