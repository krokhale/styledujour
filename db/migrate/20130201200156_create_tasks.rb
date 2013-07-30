class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title, :null => false
      t.text :description
      t.datetime :due_date
      t.datetime :completion_date
      t.boolean :is_complete, :default => false
      t.integer :user_id, :null => false
      t.integer :client_id

      t.timestamps
    end

    add_index :tasks, :user_id
    add_index :tasks, [:user_id, :is_complete]
    add_index :tasks, [:user_id, :client_id]
  end
end
