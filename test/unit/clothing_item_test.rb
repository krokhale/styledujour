# == Schema Information
#
# Table name: clothing_items
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  price              :decimal(8, 2)
#  description        :text
#  imageurl           :string(255)
#  currency           :string(255)
#  manufacturer_id    :integer
#  heir_id            :integer
#  heir_type          :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  activity_object_id :integer
#  gender             :integer(2)
#  age                :string(255)
#  category_id        :integer
#

require 'test_helper'

class ClothingItemTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert ClothingItem.new.valid?
  end
end
