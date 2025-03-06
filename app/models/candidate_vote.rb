class CandidateVote < ApplicationRecord
  belongs_to :candidate
  belongs_to :vote

  # There should not be more than one CandidateVote for
  # a given candidate per vote.
  validates_uniqueness_of :candidate, scope: :vote

  before_validation :nil_blank_feedback, :translate_in_favor_values

  private

  def nil_blank_feedback
    self.feedback = nil if self.feedback.blank?
  end

  def translate_in_favor_values
    case self.in_favor
    when "yes"
      self.in_favor = true
    when "no"
      self.in_favor = false
    else
      self.in_favor = nil
    end
  end
end
