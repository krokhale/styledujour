module UserExtended
  User.class_eval do
    has_and_belongs_to_many :bookmarks, :class_name=> "ClothingItem", :join_table => "user_bookmarked_clothing_items", :foreign_key => "user_id" 
    has_many :user_asked_clothing_items
    has_many :user_bookmarked_clothing_items
    has_many :hcit_items, :through => :user_asked_clothing_items, :source => :clothing_item
    has_many :bookmarked_items, :through => :user_bookmarked_clothing_items, :source => :clothing_item
    has_many :scores, :class_name => "UserScoredClothingItem"
    has_many :scored_items, :through => :scores, :class_name => "ClothingItem", :source=>:clothing_item
    belongs_to :actor
    has_and_belongs_to_many :points, :join_table => "points_users"
    has_many :closets, :through => :actor

    before_save :update_email
    
    def create_friendship(friend)   
      follow_relation = actor.relation_custom("friend")
      tie = Tie.create! :contact_id => self.contact_to!(friend).id, :relation_id => follow_relation.id
      recip = tie.contact.inverse!
    end

    private
    def update_email
      #this is a mess...user and actor have email
      if self.actor
        self.actor.email = self.email unless self.email.nil?
      end
    end

    def find_or_create_for_facebook_oauth(hash, signed_in_resource = nil)
      auth = Authentication.find_by_provider_and_uid(hash["provider"], hash["uid"])
      user = User.find_by_email(hash["info"]["email"])

      if user.nil?
        user = User.create!(:name => hash["info"]["name"], :email => hash["info"]["email"], :password => Devise.friendly_token[0,20])
      end

      if auth.nil?
        auth = Authentication.create!(:user_id => user.id, :uid =>hash["uid"], :provider => hash["provider"])
      end

      if hash["info"]["image"].present?
        user.update_attribute(:image, hash["info"]["image"])
      end
      user
    end
  end
end