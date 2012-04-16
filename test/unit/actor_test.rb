# == Schema Information
#
# Table name: actors
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)     default(""), not null
#  slug               :string(255)
#  subject_type       :string(255)
#  notify_by_email    :boolean         default(TRUE)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  activity_object_id :integer
#  follower_count     :integer         default(0)
#

require 'test_helper'

class ActorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
