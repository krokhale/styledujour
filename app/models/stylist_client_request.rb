# == Schema Information
#
# Table name: stylist_client_requests
#
#  id                  :integer         not null, primary key
#  stylist_id          :integer         not null
#  actor_id            :integer         not null
#  stylist_approved    :boolean
#  client_approved     :boolean
#  stylist_approved_on :datetime
#  client_approved_on  :datetime
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

class StylistClientRequest < ActiveRecord::Base
	belongs_to :stylist
	belongs_to :actor

	def client
		self.actor
	end
end
