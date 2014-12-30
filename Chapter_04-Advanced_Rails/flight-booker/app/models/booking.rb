class Booking < ActiveRecord::Base
	belongs_to :flight
	has_many :tickets
	has_many :passengers, through: :tickets
	accepts_nested_attributes_for :passengers
end