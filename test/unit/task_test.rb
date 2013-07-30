# == Schema Information
#
# Table name: tasks
#
#  id              :integer         not null, primary key
#  title           :string(255)     not null
#  description     :text
#  due_date        :datetime
#  completion_date :datetime
#  is_complete     :boolean         default(FALSE)
#  client_id       :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  actor_id        :integer
#

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
