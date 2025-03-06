class AddVoteParentModel < ActiveRecord::Migration[8.0]
  def change
    drop_table :votes
    drop_table :feedbacks

    create_table :votes do |t|
      t.belongs_to :election
      t.text :feedback
    end

    create_table :candidate_votes do |t|
      t.belongs_to :candidate
      t.boolean :in_favor, null: false
      t.text :feedback
    end
  end
end
