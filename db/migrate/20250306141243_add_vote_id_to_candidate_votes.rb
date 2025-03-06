class AddVoteIdToCandidateVotes < ActiveRecord::Migration[8.0]
  def change
    change_table :candidate_votes do |t|
      t.belongs_to :vote
    end
  end
end
