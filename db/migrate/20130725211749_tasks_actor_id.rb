class TasksActorId < ActiveRecord::Migration
  def up
  	add_column :tasks, :actor_id, :integer
  	remove_column :tasks, :user_id
  end

  def down
  	add_column :tasks, :user_id, :integer
  	remove_column :tasks, :actor_id
  end
end
