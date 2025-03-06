class Election < ApplicationRecord
  has_many :candidates, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :registrations, dependent: :destroy

  has_many :votes, through: :candidates

  def self.current
    Election.where("start_date < ?", Time.zone.now.to_date)
            .where("end_date > ?", Time.zone.now.to_date)
            .limit(1)
            &.take
  end
end
