# == Schema Information
#
# Table name: permissions
#
#  id         :integer         not null, primary key
#  action     :string(255)
#  object     :string(255)
#  function   :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'test_helper'

class PermissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
