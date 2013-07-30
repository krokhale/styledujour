class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.integer :addressable_id, :null => false
      t.string :addressable_type, :null => false

      t.timestamps
    end

    add_index :addresses, [:addressable_type, :addressable_id]
  end
end
