# == Schema Information
#
# Table name: outfits
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  closet_id          :integer
#  activity_object_id :integer
#  outfit_image       :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  info               :hstore
#

require 'test_helper'

class OutfitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
