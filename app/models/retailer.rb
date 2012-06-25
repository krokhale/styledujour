# == Schema Information
#
# Table name: retailers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  url        :string(255)
#  domain     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Retailer < ActiveRecord::Base
  has_and_belongs_to_many :clothing_items
end
