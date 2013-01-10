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
  belongs_to :point
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

  badge "Trendsetter Lvl 1" do
  	thing PointsUsers
  	subject :user
  	count do
  	  PointsUsers.joins(:point).sum("points.value") >= 100
  	end
  	icon '/assets/hcit/trndsttr_1.png'
  end

  badge "Trendsetter Lvl 2" do
  	thing PointsUsers
  	subject :user
  	count do
  	  PointsUsers.joins(:point).sum("points.value") >= 200
  	end
  	icon '/assets/hcit/trndsttr_2.png'
  end

  badge "Trendsetter Lvl 3" do
  	thing PointsUsers
  	subject :user
  	count do
  	  PointsUsers.joins(:point).sum("points.value") >= 400
  	end
  	icon '/assets/hcit/trndsttr_3.png'
  end

   badge "Style Icon Lvl 1" do
  	thing PointsUsers
  	subject :user
  	count do
  	  PointsUsers.joins(:point).sum("points.value") >= 800
  	end
  	icon '/assets/hcit/style_icon1.png' 
  end

  badge "Style Icon Lvl 2" do
  	thing PointsUsers
  	subject :user
  	count do
  	  PointsUsers.joins(:point).sum("points.value") >= 1600
  	end
  	icon '/assets/hcit/style_icon2.png'
  end

  badge "Style Icon Lvl 3" do
  	thing PointsUsers
  	subject :user
  	count do
  	  PointsUsers.joins(:point).sum("points.value") >= 3200
  	end
  	icon '/assets/hcit/style_icon3.png'
  end
end
