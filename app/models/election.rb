class Election < ApplicationRecord
  has_many :candidates, dependent: :destroy
end
