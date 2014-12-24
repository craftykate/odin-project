class EventAttendeesController < ApplicationController

	def create
		@event = Event.find(params[:event_attendee][:attended_event_id])
		current_user.event_attendees.create!(attended_event_id: @event.id)
		redirect_to @event
	end

	def destroy
	end
end
