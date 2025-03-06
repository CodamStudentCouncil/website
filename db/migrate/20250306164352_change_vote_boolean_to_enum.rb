class ChangeVoteBooleanToEnum < ActiveRecord::Migration[8.0]
  def change
    remove_column :candidate_votes, :in_favor
    add_column :candidate_votes, :in_favor, :integer, null: false
  end
end
