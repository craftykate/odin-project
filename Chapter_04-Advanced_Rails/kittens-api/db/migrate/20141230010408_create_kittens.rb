class CreateKittens < ActiveRecord::Migration
  def change
    create_table :kittens do |t|
      t.string :name
      t.integer :age
      t.string :cuteness
      t.string :softness

      t.timestamps
    end
  end
end
