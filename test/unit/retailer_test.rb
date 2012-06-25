# == Schema Information
#
# Table name: retailers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  url        :string(255)
#  domain     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'test_helper'

class RetailerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
