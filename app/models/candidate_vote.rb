class CandidateVote < ApplicationRecord
  belongs_to :candidate
  belongs_to :vote

  # There should not be more than one CandidateVote for
  # a given candidate per vote.
  validates_uniqueness_of :candidate, scope: :vote
end
