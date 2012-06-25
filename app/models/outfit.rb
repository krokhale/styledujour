class Outfit < ActiveRecord::Base
  include SocialStream::Models::Object
  acts_as_taggable_on :categories
  has_and_belongs_to_many :clothing_items
  
end
