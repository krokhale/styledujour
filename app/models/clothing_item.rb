# == Schema Information
#
# Table name: clothing_items
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  price              :decimal(8, 2)
#  description        :text
#  imageurl           :string(255)
#  currency           :string(255)
#  manufacturer_id    :integer
#  heir_id            :integer
#  heir_type          :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  activity_object_id :integer
#  gender             :integer(2)
#  age                :string(255)
#  category_id        :integer
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

require 'open-uri'
class ClothingItem < ActiveRecord::Base
  attr_accessor :clothing_item_image_base64
  include SocialStream::Models::Object
  parent_model
  attr_accessible :name, :price, :description, :imageurl, :currency, :retailer_id, :manufacturer_id, :category_id, :photo
  attr_accessible :author_id, :user_author_id, :owner_id, :activity_object_id, :clothing_item_image_base64

  has_and_belongs_to_many :bookmarkers, :class_name=> "User", :join_table => "user_bookmarked_clothing_items", :foreign_key => "clothing_item_id"
  has_many :user_asked_clothing_items
  has_many :user_scored_clothing_items

  has_many :askers, :through => :user_asked_clothing_items, :class_name => "User", :source=>:user
  has_many :scores, :class_name => "UserScoredClothingItem"
  has_many :scorers, :through => :user_scored_clothing_items, :class_name => "User", :source=>:user

  has_and_belongs_to_many :retailers
  belongs_to :manufacturer
  belongs_to :category

  has_attached_file :photo,
    :styles => {
      :thumb => "100x100>",
      :medium => "x150"
      },
    :path => '/:class/:id/:attachment/:style/:filename',
    :storage => :s3,
    :s3_credentials => S3_CREDENTIALS

    before_validation :setup_photo, :if => :clothing_item_image_base64_provided?

  scope :public, lambda {
    channels   = Channel.arel_table
    audiences  = Audience.arel_table
    relations  = Relation.arel_table

     audience_conditions = audiences[:relation_id].in("0").or(relations[:type].eq('Relation::Public'))
     select("clothing_items.*").joins(:activity_object => [:activities => [:channel,:audiences, :relations]]).includes(:heir).where(audience_conditions)

  }
  def photo_url
    self.photo.url
  end

  def overall_hcit_score
    return nil if self.scores.shopped.count == 0
    BigDecimal.new((self.scores.shopped.sum(:price) / BigDecimal.new(self.scores.shopped.count)).to_s
  end

  def shopped_count
    self.scores.shopped.count
  end

  def dropped_count
    self.scores.dropped.count
  end

  def score_for(user)
    self.scores.where(:user_id=>user).try(:first).try(:price)
  end

  def photo_from_url(url)
    self.update_attribute(:photo, open(url))
  end

  def clothing_item_image_base64_provided?
    !self.clothing_item_image_base64.blank?
  end

  def setup_photo
    base64data = self.clothing_item_image_base64.split(',')
    data = StringIO.new(Base64.decode64(base64data.last))
    data.class.class_eval { attr_accessor :original_filename, :content_type }
    data.original_filename = "#{self.name.parameterize}.jpeg"
    data.content_type = "image/jpeg"
    self.photo = data
  end
  ##FOR SOCIAL_STREAM

  def title
    name.truncate(30, :separator => ' ')
  end

  def create_scored_activity(verb, user)
    #because I don't want to modify activity_object.rb yet

    a = Activity.new :verb         => verb,
                     :author_id    => user.actor.id,
                     :user_author  => user.actor,
                     :owner        => user.actor,
                     :relation_ids => _relation_ids,
                     :parent_id    => _activity_parent_id

    a.activity_objects << self.activity_object

    a.save!
  end

    # Is subject allowed to perform action on this {Activity}?
  def allow?(subject, action)
    return false if channel.blank?

    case action
    when 'create'
      return false if subject.blank? || channel.author_id != Actor.normalize_id(subject)

      rels = Relation.normalize(relation_ids)

      own_rels = rels.select{ |r| r.actor_id == channel.author_id }
      # Consider Relation::Single as own_relations
      own_rels += rels.select{ |r| r.is_a?(Relation::Single) }

      foreign_rels = rels - own_rels

      # Only posting to own relations or allowed to post to foreign relations
      return foreign_rels.blank? && own_rels.present? ||
             foreign_rels.present? && Relation.allow(subject,
                                                     action,
                                                     'activity',
                                                     :in => foreign_rels).
                                               all.size == foreign_rels.size

    when 'read'
      return true
    when 'update'
      return true if [channel.author_id, channel.owner_id].include?(Actor.normalize_id(subject))
    when 'destroy'
      # We only allow destroying to sender and receiver by now
      return [channel.author_id, channel.owner_id].include?(Actor.normalize_id(subject))
    end

    Relation.
      allow?(subject, action, 'activity', :in => self.relation_ids, :public => false)
  end

  def as_json(options)
    super(options.merge(:url =>self.photo.try(:url)))
  end
end

