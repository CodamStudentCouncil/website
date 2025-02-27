class CreateVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :votes do |t|
      t.belongs_to :candidate, null: false, foreign_key: true
      t.boolean    :in_favor,  null: false
      t.text       :comment
    end
  end
end
