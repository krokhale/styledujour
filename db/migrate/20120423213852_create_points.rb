class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :value, :default => 0
      t.string :action
      t.string :description
      t.boolean :repeatable, :default => false
      t.integer :cooldown, :default => 0

      t.timestamps
    end
    
		create_table :points_users, :force => true do |t|
		    t.integer :point_id
		    t.integer :user_id
		    t.timestamps
		end
		
		add_index :points, :action
		add_index :points_users, :point_id
		add_index :points_users, :user_id
		
		add_column :users, :points_earned_cache, :integer
  end
end
