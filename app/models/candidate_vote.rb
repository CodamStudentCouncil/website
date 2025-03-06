class CandidateVote < ApplicationRecord
  belongs_to :candidate
  belongs_to :vote

  enum :in_favor, [ :yes, :no, :abstain ]

  # There should not be more than one CandidateVote for
  # a given candidate per vote.
  validates_uniqueness_of :candidate, scope: :vote

  before_validation :nil_blank_feedback

  private

  def nil_blank_feedback
    self.feedback = nil if self.feedback.blank?
  end
end
