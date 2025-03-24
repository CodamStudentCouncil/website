class CandidateVote < ApplicationRecord
  belongs_to :candidate
  belongs_to :vote

  enum :in_favor, [ :yes, :no, :abstain ]

  # There should not be more than one CandidateVote for
  # a given candidate per vote.
  validates_uniqueness_of :candidate, scope: :vote

  validates_presence_of :in_favor, message: "Please fill out your vote for this candidate"

  validate :candidate_should_belong_to_this_election

  before_validation :nil_blank_feedback

  validates :feedback, length: { maximum: 4096 }

  private

  def nil_blank_feedback
    self.feedback = nil if self.feedback.blank?
  end

  def candidate_should_belong_to_this_election
    if self.candidate&.election_id != self.vote&.election_id
      errors.add(:candidate, "can't belong to another election")
    end
  end
end
