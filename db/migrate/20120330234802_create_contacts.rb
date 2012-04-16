class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :inverse_id
      t.integer :ties_count

      t.timestamps
    end
    
		add_index "contacts", "receiver_id"
    add_index "contacts", "sender_id"
    add_index "contacts", "inverse_id"
  end
end
