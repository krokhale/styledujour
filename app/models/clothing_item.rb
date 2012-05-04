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
#  retailer_id        :integer
#  manufacturer_id    :integer
#  heir_id            :integer
#  heir_type          :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  activity_object_id :integer
#

class ClothingItem < ActiveRecord::Base
  include SocialStream::Models::Object
  parent_model
  attr_accessible :name, :price, :description, :imageurl, :currency, :retailer_id, :manufacturer_id
  attr_accessible :author_id, :user_author_id, :owner_id, :activity_object_id
  
  has_and_belongs_to_many :bookmarkers, :class_name=> "User", :join_table => "user_bookmarked_clothing_items", :foreign_key => "clothing_item_id"   
  has_many :user_asked_clothing_items
  has_many :user_scored_clothing_items
  
  has_many :askers, :through => :user_asked_clothing_items, :class_name => "User", :source=>:user
  has_many :scores, :class_name => "UserScoredClothingItem"
  has_many :scorers, :through => :user_scored_clothing_items, :class_name => "User", :source=>:user
  
  
  def overall_hcit_score
    return nil if self.scores.shopped.count == 0 
    (self.scores.shopped.sum(:price) / self.scores.shopped.count)
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
end
