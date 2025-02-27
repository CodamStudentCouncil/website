class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.string :username, null: false
      t.string :photo_url

      t.timestamps
      t.index [ :username ], unique: true
    end
  end
end
