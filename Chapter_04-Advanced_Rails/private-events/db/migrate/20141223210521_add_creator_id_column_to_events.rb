class AddCreatorIdColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :creator_id, :string
  end
end
