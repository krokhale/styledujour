# == Schema Information
#
# Table name: tasks
#
#  id              :integer         not null, primary key
#  title           :string(255)     not null
#  description     :text
#  due_date        :datetime
#  completion_date :datetime
#  is_complete     :boolean         default(FALSE)
#  client_id       :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  actor_id        :integer
#

class Task < ActiveRecord::Base
  attr_accessible :client_id, :completion_date, :description, :due_date, :is_complete, :title, :actor_id

  belongs_to :actor
  has_one :client, class_name: "Actor", foreign_key: "client_id"
  validates :title, :presence => true
  validates :actor_id, :presence => true

  scope :completed, where(:is_complete=>true)
  scope :incomplete, where(:is_complete=>false)
  scope :for_client, lambda {|client| where(client_id: client) }
  scope :due_today, where("due_date < ? AND due_date > ?", DateTime.tomorrow, DateTime.yesterday)
end
