# == Schema Information
#
# Table name: categories
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  parent_id         :integer
#  lft               :integer
#  rgt               :integer
#  source            :string(255)
#  source_identifier :integer
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#

class Category < ActiveRecord::Base
  acts_as_nested_set
  attr_accessible :name, :parent_id, :source, :source_identifier
  has_many :clothing_items
end
