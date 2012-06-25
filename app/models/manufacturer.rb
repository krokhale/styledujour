# == Schema Information
#
# Table name: manufacturers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Manufacturer < ActiveRecord::Base
  has_many :clothing_items
end
