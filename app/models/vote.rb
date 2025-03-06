class Vote < ApplicationRecord
  belongs_to :election

  validates_associated :candidate_votes

  accepts_nested_attributes_for :candidate_votes
end
