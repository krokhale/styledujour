class Api::V1::HcitController < ApplicationController
	before_filter :authenticate_user!
	skip_before_filter :verify_authenticity_token

	def ask_user
		@invite = AskHCIT.new
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
		@invites = AskHCIT.unanswered.find_by_receiver_id(current_actor.id)

		respond_to do |format|

	      format.json {
	      	render :json =>@invites.to_json(:include => [:clothing_item]) ,:callback => params[:callback]
	      }
    	end
	end
end

