class AllowNullOnCandidateVotesInFavor < ActiveRecord::Migration[8.0]
  def change
    change_column :candidate_votes, :in_favor, :boolean, null: true
  end
end
