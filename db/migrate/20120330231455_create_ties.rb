class CreateTies < ActiveRecord::Migration
  def change
    create_table :ties do |t|
      t.integer :contact_id
      t.integer :relation_id
      t.timestamps
    end
    
		add_index :ties, :contact_id
		add_index :ties, :relation_id
		

  end
end
