class CreateEventAttendees < ActiveRecord::Migration
  def change
    create_table :event_attendees do |t|
    	t.string :attendee_id
    	t.string :attended_event_id
      t.timestamps
    end
  end
end
