# == Schema Information
#
# Table name: linked_clothing_items
#
#  id                 :integer         not null, primary key
#  item_url           :string(255)     not null
#  activity_object_id :integer
#

require 'test_helper'

class LinkedClothingItemTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert LinkedClothingItem.new.valid?
  end
end
