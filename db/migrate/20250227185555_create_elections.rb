class CreateElections < ActiveRecord::Migration[8.0]
  def change
    create_table :elections do |t|
      t.date    :start,       null: false, default: -> { 'now()' }
      t.integer :days_to_run, null: false, default: 7

      t.timestamps
    end
  end
end
