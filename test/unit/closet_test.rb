# == Schema Information
#
# Table name: closets
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  actor_id   :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  slug       :string(255)
#

require 'test_helper'

class ClosetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
