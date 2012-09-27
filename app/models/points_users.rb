# == Schema Information
#
# Table name: points_users
#
#  id         :integer         not null, primary key
#  point_id   :integer
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class PointsUsers < ActiveRecord::Base
  belongs_to :points
  belongs_to :user
  
  extend Badgeable::Award

  badge "Shopholic Lvl 1" do
  	thing PointsUsers
  	subject :user
  	count 3
  	icon '/assets/hcit/shpholic_1.png'
  end

  badge "Shopholic Lvl 2" do
  	thing PointsUsers
  	subject :user
  	count 15
  	icon '/assets/hcit/shpholic_2.png'
  end

  badge "Shopholic Lvl 3" do
  	thing PointsUsers
  	subject :user
  	count 30
  	icon '/assets/hcit/shpholic_3.png'
  end
end
