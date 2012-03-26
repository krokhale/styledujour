class CreateUserBookmarkedClothingItems < ActiveRecord::Migration
  def change
    create_table :user_bookmarked_clothing_items, :id=>false do |t|
      t.integer :user_id, :null => false
      t.integer :clothing_item_id, :null => false

      t.timestamps
    end
    
		add_index :user_bookmarked_clothing_items, :user_id
		add_index :user_bookmarked_clothing_items, :clothing_item_id
  end
end
