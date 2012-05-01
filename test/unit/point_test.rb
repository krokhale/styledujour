# == Schema Information
#
# Table name: points
#
#  id          :integer         not null, primary key
#  value       :integer         default(0)
#  action      :string(255)
#  description :string(255)
#  repeatable  :boolean         default(FALSE)
#  cooldown    :integer         default(0)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'test_helper'

class PointTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
