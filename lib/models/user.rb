module UserExtended
  User.class_eval do
    has_and_belongs_to_many :bookmarks, :class_name=> "ClothingItem", :join_table => "user_bookmarked_clothing_items", :foreign_key => "user_id" 
    has_many :user_asked_clothing_items
    has_many :user_bookmarked_clothing_items
    has_many :hcit_items, :through => :user_asked_clothing_items, :source => :clothing_item
    has_many :bookmarked_items, :through => :user_bookmarked_clothing_items, :source => :clothing_item
    has_many :scores, :class_name => "UserScoredClothingItem"
    has_many :scorered_items, :through => :scores, :class_name => "ClothingItem", :source=>:clothing_item
    belongs_to :actor
    
    has_and_belongs_to_many :points, :join_table => "points_users"
    
    private
    def find_or_create_for_facebook_oauth(hash, signed_in_resource = nil)
      puts hash.inspect
      auth = Authentication.find_by_provider_and_uid(hash["provider"], hash["uid"])
      user = User.find_by_email(hash["info"]["email"])

      if user.nil?
        user = User.new(:name => hash["info"]["name"], :email => hash["info"]["email"], :password => Devise.friendly_token[0,20])
        user.build_actor
        user.save!
      end

      if auth.nil?
        auth = Authentication.create!(:user_id => user.id, :uid =>hash["uid"], :provider => hash["provider"])
      end

      user
    end
  end
end