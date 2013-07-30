class ClientsController < InheritedResources::Base
	belongs_to :stylist
	respond_to :html, :json
	custom_actions :resource => :status, :collection => :statuses

	def status
		@client = resource.stylist_client_requests.where(:stylist_id=>parent).first
		status!
	end

	def statuses	
		@clients = parent.stylist_client_requests	
		statuses!
	end
end