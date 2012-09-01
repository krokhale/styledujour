class AskHCIT < ActiveRecord::Base
  belongs_to :sender, :class_name => "Actor"
  belongs_to :receiver, :class_name => "Actor"
  belongs_to :clothing_item
  belongs_to :user_scored_clothing_item
  
  scope :unanswered, where(:user_scored_clothing_item_id=>nil)

end
