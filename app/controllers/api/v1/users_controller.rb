class Api::V1::UsersController < ApplicationController
	before_filter :authenticate_user!

	def contacts
	  	if !params[:id]
	      params[:id]=current_user.to_param
	    end
	    
	    if !params[:format]
	      params[:format]='json'
	    end
	  redirect_to :controller => "/contacts", :action => :index, :format => params[:format], 
	  	:id => params[:id], :auth_token => params[:auth_token], :page => params[:page], :letter => params[:letter], :search => params[:search], :relation => params[:relation]
	end

	def facebook_invites
		@invites = FacebookUserClothingInvite.by_user(current_user).page(params[:page]).limit(10)

		respond_to do |format|
	      format.js { @invites = @invites }
	      format.json { render :json => @invites.to_json(:except=>[:id, :updated_at, :created_at]), :callback => params[:callback] }
    	end
	end

	def check_facebook_friend
		@invite = FacebookUserClothingInvite.by_facebook(params[:facebook_id])

		respond_to do |format|
	      format.js { @invite = @invite }
	      format.json { render :json => @invite.to_json(:except=>[:id, :updated_at, :created_at]), :callback => params[:callback] }
    	end
	end

	def contacts_in_network
		@users = nil
		if params[:network] == "facebook"
		  fb = FbGraph::User.me(params[:token])
		  friends = fb.friends.map { |friend| friend.identifier }


		  @users = Authentication.includes(:user).where(:provider=>"facebook", :uid=>friends).map { |a| a.user }

		end

		respond_to do |format|
	      format.js { @invite = @users }
	      format.json { render :json => @users, :callback => params[:callback] }
    	end	
	end

	def request_friendships
		friends = params[:friends]
		follow_relation = current_actor.relation_custom("friend")
		friends.each do |f|
			friend = User.find(f)
      		tie = Tie.create! :contact_id => current_user.contact_to!(friend).id, :relation_id => follow_relation.id
		end
	end

	def friendship_requests
		@requests = current_actor.received_contacts.pending

		respond_to do |format|
	      format.js { @requests = @requests }
	      format.json { render :json => @requests.to_json(:except=>[:inverse_id, :ties_count, :updated_at], :methods=>[:sender_name, :receiver_name]), :callback => params[:callback] }
    	end
	end

	def accept_friendship
		@request = current_actor.received_contacts.pending.find(params[:id])
		if @request
			tie = Tie.create! :contact_id => @request.id, :relation_id => @request.relations.first.id
	      	recip = tie.contact.inverse!
	    end
	end
end