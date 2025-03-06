class Registration < ApplicationRecord
  belongs_to :election

  validates :username, presence: true,
                       uniqueness: { scope: :election }
end
