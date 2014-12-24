class Event < ActiveRecord::Base
	belongs_to :creator, :class_name => "User"
	has_many :event_attendees, :foreign_key => :attended_event_id
	has_many :attendees, :through => :event_attendees

	validates :title, presence: true
	validates :event_location, presence: true

	default_scope -> { order('event_date ASC')}
	scope :future, -> { where "event_date > ?", Time.zone.now }
	scope :past, -> { where "event_date <= ?", Time.zone.now }
end
