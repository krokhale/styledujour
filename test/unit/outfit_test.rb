# == Schema Information
#
# Table name: outfits
#
#  id                        :integer         not null, primary key
#  name                      :string(255)
#  closet_id                 :integer
#  activity_object_id        :integer
#  created_at                :datetime        not null
#  updated_at                :datetime        not null
#  info                      :hstore
#  outfit_image_file_name    :string(255)
#  outfit_image_content_type :string(255)
#  outfit_image_file_size    :string(255)
#  outfit_image_processing   :boolean
#

require 'test_helper'

class OutfitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
