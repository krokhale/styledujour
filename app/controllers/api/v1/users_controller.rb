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

	
end