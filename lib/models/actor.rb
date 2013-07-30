module ActorExtended
  Actor.class_eval do
  	has_many :stylist_client_requests
  	has_many :stylists,  :through => :stylist_client_requests
  	has_one :closet
  	has_many :tasks
  end
end