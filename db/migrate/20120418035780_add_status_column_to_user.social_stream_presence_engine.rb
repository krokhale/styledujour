# This migration comes from social_stream_presence_engine (originally 20110928135031)
class AddStatusColumnToUser < ActiveRecord::Migration
  def self.up
     add_column :users, :status, :string, :default => "available"
		add_column :users, :email, :string ### HAD TO ADD EMAIL BACK...UNSURE WHY CODE SUCKS
  end

  def self.down
		remove_column :users, :email
    remove_column :users, :status
  end
end
