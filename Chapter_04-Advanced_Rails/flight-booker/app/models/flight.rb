class Flight < ActiveRecord::Base
	belongs_to :from_airport, :foreign_key => :start_location, :class_name => "Airport"
	belongs_to :to_airport, :foreign_key => :end_location, :class_name => "Airport"
	has_many :bookings

	def self.search(params)
		@message = ""
		if params[:search]
			format_date = date_format(params[:chosen_date])
			Flight.where("start_location = ? AND end_location = ? AND start_time LIKE ?", params[:from], params[:to], "%#{format_date}%")
		else
			Flight.none
		end
	end

	def self.date_format(date)
		year = date[6..9]
		month = date[0..1]
		day = date[3..4]
		return "#{year}-#{month}-#{day}"
	end
end
