class Airport < ActiveRecord::Base
	has_many :departures, :foreign_key => :start_location, :class_name => "Flight"
	has_many :arrivals, :foreign_key => :end_location, :class_name => "Flight"
end
