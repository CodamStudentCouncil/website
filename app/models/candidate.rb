class Candidate < ApplicationRecord
  belongs_to :election
  has_many   :votes, dependent: :destroy

  def profile_url
    "https://profile.intra.42.fr/users/#{self.username}"
  end
end
