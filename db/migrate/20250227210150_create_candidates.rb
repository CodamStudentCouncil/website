class CreateCandidates < ActiveRecord::Migration[8.0]
  def change
    create_table :candidates do |t|
      t.string     :username,    null: false
      t.string     :full_name,   null: false
      t.string     :photo_url
      t.string     :focus_area
      t.text       :description
      t.belongs_to :election, null: false, foreign_key: true

      t.timestamps

      t.index [ :username, :election_id ], unique: true
    end
  end
end
