class EventsController < ApplicationController
	before_action :logged_in_user
	
	def show
		@event = Event.find(params[:id])
	end

	def new
		@event = Event.new
	end

	def create
		@event = current_user.created_events.build(event_params)
		if @event.save
			flash[:success] = "Event saved!"
			redirect_to user_path(current_user)
		else
			render :new
		end
	end

	private

		def event_params
			params.require(:event).permit(:event_location, :description, :event_date, :title)
		end
# end private
end
