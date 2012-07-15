# == Schema Information
#
# Table name: outfits
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  closet_id          :integer
#  activity_object_id :integer
#  outfit_image       :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  info               :hstore
#

class Outfit < ActiveRecord::Base
  serialize :info, ActiveRecord::Coders::Hstore	
  include SocialStream::Models::Object
  acts_as_taggable_on :categories
  has_and_belongs_to_many :clothing_items
  
end
