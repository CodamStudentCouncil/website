class Vote < ApplicationRecord
  has_many :candidate_votes, dependent: :destroy
  belongs_to :election

  validates_associated :candidate_votes


  accepts_nested_attributes_for :candidate_votes

  validates :candidate_votes, nested_attributes_uniqueness: { field: :candidate_id }

  before_validation :nil_blank_feedback

  private

  def nil_blank_feedback
    self.feedback = nil if self.feedback.blank?
  end
end
