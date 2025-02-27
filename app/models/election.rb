class Election < ApplicationRecord
  has_many :candidates, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :registrations, dependent: :destroy

  has_many :votes, through: :candidates
end
