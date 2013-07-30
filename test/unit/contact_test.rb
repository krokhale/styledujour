# == Schema Information
#
# Table name: contacts
#
#  id          :integer         not null, primary key
#  sender_id   :integer
#  receiver_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  inverse_id  :integer
#  ties_count  :integer         default(0)
#

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
