class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string   "name"
      t.string   "email",     :default => "", :null => false
      t.string   "slug"
      t.string   "subject_type"
      t.boolean  "notify_by_email", :default => true
      t.timestamps
      t.integer  "activity_object_id"
      t.integer  "follower_count", :default => 0
    end
    
    add_index "actors", "activity_object_id"
    add_index "actors", "email"
    add_index "actors", "slug", :unique => true

		add_column :users, :actor_id, :integer
	
  end
end
