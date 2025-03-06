class IndexCandidateVotes < ActiveRecord::Migration[8.0]
  def change
    add_index :candidate_votes, [ :candidate_id, :in_favor ]
  end
end
