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

class Stylist < ActiveRecord::Base
  include SocialStream::Models::Subject
  attr_accessible :about_me, :actor_id, :facebook, :google, :phone, :pinterest, :twitter, :website, :youtube_video
  has_one :address, :as=>:addressable
  belongs_to :actor
  has_many :stylist_client_requests
  has_many :clients, :through => :stylist_client_requests,  :source => :actor
  #has_many :images, :as => :imageable, :dependent => :destroy, :order => "case when is_default ='true' then 1 else 2 end"
  def name
  	self.actor.name
  end
end
