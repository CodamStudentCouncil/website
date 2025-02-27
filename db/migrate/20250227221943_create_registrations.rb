class CreateRegistrations < ActiveRecord::Migration[8.0]
  def change
    create_table :registrations do |t|
      t.belongs_to :student, null: false, foreign_key: true
      t.belongs_to :election, null: false, foreign_key: true

      t.timestamps

      t.index [ :student_id, :election_id ], unique: true
    end
  end
end
