# == Schema Information
#
# Table name: relations
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  sender_type   :string(255)
#  receiver_type :string(255)
#  parent_id     :integer
#  lft           :integer
#  rgt           :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'test_helper'

class RelationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
