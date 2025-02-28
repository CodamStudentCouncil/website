class RemoveStudentsTable < ActiveRecord::Migration[8.0]
  def change
    remove_column :registrations, :student_id
    add_column    :registrations, :username, :string,  null: false

    add_index :registrations, [ :username, :election_id ], unique: true

    drop_table :students
  end
end
