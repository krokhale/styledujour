# == Schema Information
#
# Table name: addresses
#
#  id               :integer         not null, primary key
#  address_1        :string(255)
#  address_2        :string(255)
#  city             :string(255)
#  state            :string(255)
#  zip              :string(255)
#  addressable_id   :integer         not null
#  addressable_type :string(255)     not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
