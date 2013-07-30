# == Schema Information
#
# Table name: stylists
#
#  id            :integer         not null, primary key
#  actor_id      :integer         not null
#  youtube_video :string(255)
#  about_me      :text
#  facebook      :string(255)
#  twitter       :string(255)
#  google        :string(255)
#  pinterest     :string(255)
#  website       :string(255)
#  phone         :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'test_helper'

class StylistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
