class Api::V1::HcitController < ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :authenticate_user!

	def ask_user
		@invite = AskHcit.new
		@invite.sender = current_actor
		@invite.receiver_id = User.find_by_id(params[:receiver_id]).try(:actor).try(:id)
		@invite.clothing_item = ClothingItem.find_by_id(params[:clothing_item_id])

		respond_to do |format|

	      format.json {
	      	if @invite.save
	      		render :json =>{:callback => params[:callback], status: :success }
	      	else
	      		render :json => {error: "invalid request", status: :unprocessable_entity}
	      	end
	      }
    	end
	end

	def answer_queue
		@invites = AskHcit.unanswered.where(:receiver_id=>current_actor.id)

		respond_to do |wants|

	      wants.json {
	      	render :json =>@invites,:callback => params[:callback]
	      }
    	end
	end

	def my_asks_count
		@count = current_user.hcit_items.count
	    respond_to do |wants|
	      wants.html {}
	      wants.json { render :json=> {clothing_items: @count}, :status => 200 } 
	    end
	end

	def my_scores_count
		@count = current_user.scores.count
	    respond_to do |wants|
	      wants.html {}
	      wants.json { render :json=> {scores: @count}, :status => 200 } 
	    end
	end

	def my_badges
		@badges = current_user.badges
		respond_to do |wants|
	      
	      wants.json { render :json=> @badges, :status => 200 } 
	    end
	end
end

