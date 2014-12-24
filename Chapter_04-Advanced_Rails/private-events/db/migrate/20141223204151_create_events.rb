class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_location
      t.datetime :event_date
      t.text :description

      t.timestamps
    end
  end
end
