class ActorsStylists < ActiveRecord::Migration
  def change
  	create_table :actors_stylists, :id=>false do |t|
  		t.references :actor, :null => false
  		t.references :stylist, :null => false
  	end

  	add_index :actors_stylists, [:actor_id, :stylist_id]

  	create_table :stylist_client_requests do |t|
  		t.references :stylist, :null => false
  		t.references :actor, :null => false
  		t.boolean :stylist_approved
  		t.boolean :client_approved
  		t.datetime :stylist_approved_on
  		t.datetime :client_approved_on
  		t.timestamps
  	end

  	add_index :stylist_client_requests, :stylist_id
  	add_index :stylist_client_requests, :actor_id

  end

end
