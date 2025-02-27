class Registration < ApplicationRecord
  belongs_to :student
  belongs_to :election
end
