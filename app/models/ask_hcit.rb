# == Schema Information
#
# Table name: ask_hcits
#
#  id                           :integer         not null, primary key
#  clothing_item_id             :integer         not null
#  sender_id                    :integer         not null
#  receiver_id                  :integer         not null
#  user_scored_clothing_item_id :integer
#  created_at                   :datetime        not null
#  updated_at                   :datetime        not null
#

class AskHcit < ActiveRecord::Base
  belongs_to :sender, :class_name => "Actor"
  belongs_to :receiver, :class_name => "Actor"
  belongs_to :clothing_item
  belongs_to :user_scored_clothing_item
  
  scope :unanswered, where(:user_scored_clothing_item_id=>nil)

end
