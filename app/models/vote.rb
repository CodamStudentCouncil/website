# A vote is a single yay or nay about a specific candidate,
# and therefore in a specific election.
class Vote < ApplicationRecord
  belongs_to :candidate
end
