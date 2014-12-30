class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :name

      t.timestamps
    end
  end
end
