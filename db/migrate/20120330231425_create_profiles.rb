class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.date :birthday
      t.string :description
      t.references :actor
      t.timestamps
    end
    
    add_index "profiles", "actor_id"
    
  end
end
