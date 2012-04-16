# == Schema Information
#
# Table name: profiles
#
#  id          :integer         not null, primary key
#  birthday    :date
#  description :string(255)
#  actor_id    :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Profile < ActiveRecord::Base
  belongs_to :actor
end
