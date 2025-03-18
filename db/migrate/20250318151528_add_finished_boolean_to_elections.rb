class AddFinishedBooleanToElections < ActiveRecord::Migration[8.0]
  def change
    add_column :elections, :finalized, :boolean, null: false, default: false
  end
end
