class CreateStylists < ActiveRecord::Migration
  def change
    create_table :stylists do |t|
      t.integer :actor_id, :null => false
      t.string :youtube_video
      t.text :about_me
      t.string :facebook
      t.string :twitter
      t.string :google
      t.string :pinterest
      t.string :website
      t.string :phone

      t.timestamps
    end

    add_index :stylists, :actor_id
    
  end
end
