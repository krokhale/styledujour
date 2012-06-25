# == Schema Information
#
# Table name: affiliate_clothing_items
#
#  id                   :integer         not null, primary key
#  activity_object_id   :integer
#  item_url             :string(255)
#  mpn                  :string(255)
#  upc                  :string(255)
#  sku                  :string(255)
#  is_accessory         :boolean
#  skimlinks_product_id :string(255)
#  skimlinks_group_id   :integer
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#

require 'test_helper'

class AffiliateClothingItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
