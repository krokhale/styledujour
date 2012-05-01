# == Schema Information
#
# Table name: activity_verbs
#
#  id         :integer         not null, primary key
#  name       :string(45)
#  created_at :datetime
#  updated_at :datetime
#

## OVERRIDE SOCIAL_STREAM
class ActivityVerb < ActiveRecord::Base
  # Activity Strems verbs
  Available = %w(follow like make-friend post update shop drop)

  validates_uniqueness_of :name

  has_many :activities

  scope :verb_name, lambda{ |n|
    where(:name => n)
  }

  class << self
    def [] name
      if Available.include?(name)
        find_or_create_by_name name
      else
        raise "ActivityVerb not available: #{ name }"
      end
    end
  end
end
