class CreateCouncilsAndCouncilMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :councils do |t|
      t.date :start_date, null: false
      t.date :end_date

      t.timestamps

      t.index :start_date
    end

    create_table :council_members do |t|
      t.string :username,  null: false
      t.string :full_name
      t.string :photo_url
      t.string :focus_area
      t.text :bio
      t.belongs_to :council, null: false, foreign_key: true

      t.timestamps

      t.index [ :council_id, :username ]
    end
  end
end
