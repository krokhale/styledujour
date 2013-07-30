class TasksController < InheritedResources::Base
	before_filter :authenticate_user!
	respond_to :html, :json
	load_and_authorize_resource :except => [:index]

	protected
    def begin_of_association_chain
      @current_user
    end
end
