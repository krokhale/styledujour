class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.string :name
      t.string :sender_type
      t.string :receiver_type
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end
    
    
  end
end
