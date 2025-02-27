class CreateFeedbacks < ActiveRecord::Migration[8.0]
  def change
    create_table :feedbacks do |t|
      t.belongs_to :election, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
