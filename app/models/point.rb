# == Schema Information
#
# Table name: points
#
#  id          :integer         not null, primary key
#  value       :integer         default(0)
#  action      :string(255)
#  description :string(255)
#  repeatable  :boolean         default(FALSE)
#  cooldown    :integer         default(0)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Point < ActiveRecord::Base
  has_many :points_users, :class_name => "PointsUsers", :foreign_key => "point_id"
  has_many :users, :through => :points_users, :source => :user
  #has_and_belongs_to_many :users, :join_table => "points_users"
  
  def self.award(user, action)
    
    point = Point.find_by_action(action)
    
    if point
      point.points_users.create!(:user=>user)
      user.update_attribute(:points_earned_cache, user.points.sum(:value))
      #point.save!
      return true
    end
    
    return false
  end
end
