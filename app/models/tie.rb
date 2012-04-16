# == Schema Information
#
# Table name: ties
#
#  id          :integer         not null, primary key
#  contact_id  :integer
#  relation_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Tie < ActiveRecord::Base
end
