# == Schema Information
#
# Table name: outfits
#
#  id                        :integer         not null, primary key
#  name                      :string(255)
#  closet_id                 :integer
#  activity_object_id        :integer
#  created_at                :datetime        not null
#  updated_at                :datetime        not null
#  info                      :hstore
#  outfit_image_file_name    :string(255)
#  outfit_image_content_type :string(255)
#  outfit_image_file_size    :string(255)
#  outfit_image_processing   :boolean
#

class Outfit < ActiveRecord::Base
  attr_accessor :outfit_image_base64
  serialize :info, ActiveRecord::Coders::Hstore	
  include SocialStream::Models::Object
  acts_as_taggable_on :categories
  has_and_belongs_to_many :clothing_items
  has_attached_file :outfit_image,
  	:styles => {
  		:full => "800x600",
  		:small => "400x300",
  		:thumb => "100x100#"
  		},
  	:storage => :s3,
  	:s3_credentials => "#{Rails.root}/config/s3.yml",
  	:path => "/:class/:id/:style/:filename"

  before_validation :setup_photo, :if => :outfit_image_base64_provided?
  before_save :check_info_for_array
  attr_accessible  :name, :closet_id, :info, :outfit_image_base64
  attr_accessible :author_id, :user_author_id, :owner_id, :activity_object_id

  def info_clean
  	return nil unless self.info
  	eval(self.info["info"])
  end

  def image
  	self.outfit_image.to_s
  end

  # For Activity Atom Stream
  def text
    self.name
  end

  private

  def setup_photo
  	# return true unless outfit_image_base64
  	# StringIO.open(Base64.decode64(self.outfit_image_base64)) do |data|
  	# 	data.original_filename = "#{title.parameterize}.png"
  	# 	data.content_type = "image/png"
  	# 	self.outfit_image = data
  	# end
  	base64data = self.outfit_image_base64.split(',')
  	data = StringIO.new(Base64.decode64(base64data[1]))
    data.class.class_eval { attr_accessor :original_filename, :content_type }
    data.original_filename = "#{self.name.parameterize}.png"
    data.content_type = "image/png"
    self.outfit_image = data
  end

  def outfit_image_base64_provided?
    !self.outfit_image_base64.blank?
  end

  def check_info_for_array
  	Rails.logger.info("Info is a ... " + self.info.class.to_s)
  	Rails.logger.info("Info is ... " + self.info.to_s)
  	if self.info.is_a? Array
  		self.info = {:info=>self.info}
  	end
  end
end
