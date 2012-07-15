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

class Closet < ActiveRecord::Base
  has_and_belongs_to_many :clothing_items
  belongs_to :actor
  has_many :outfits
  acts_as_url :name, :url_attribute => :slug, :sync_url => true
end
