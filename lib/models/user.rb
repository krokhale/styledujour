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
  end
end