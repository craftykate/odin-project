class FlightsController < ApplicationController

	def index
		@airports = Airport.all.map { |a| [a.name, a.id] }
		@dates = Flight.all.order(:start_time)
		@dates = @dates.map { |d| d.start_time.strftime("%m/%d/%Y") }
		@dates.uniq!
		@flights = Flight.search(params).order(:start_time)
		@chosen_from = params[:from]
		@chosen_to = params[:to]
		@chosen_pass = params[:passenger_count]
		@chosen_date = params[:chosen_date]
		@message = ""
		if @chosen_from == "" || @chosen_to == ""
			@message = "Please chose two airports"
		elsif @chosen_from == @chosen_to
			@message = "Please choose two different airports"
		end
		if @message == "" && @chosen_pass == ""
			@message = "Please choose number of passengers"
		end
		if @message == "" && @chosen_date == ""
			@message = "Please chose a date to fly"
		end
	end

end
