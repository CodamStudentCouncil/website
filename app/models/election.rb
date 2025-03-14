class Election < ApplicationRecord
  has_many :candidates, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates_presence_of :start_date, :end_date
  validates :end_date, comparison: { greater_than: :start_date }


  def self.current
    self.during_date(Time.zone.now.to_date)
  end

  def self.during_date(date)
    Election.where("start_date <= ?", date)
            .where("end_date > ?", date)
            .limit(1)
            &.take
  end

  private

  def no_election_during_date
    if Election.during_date(self.start_date)
      errors.add(:start_date, "cannot be during another election")
    end

    if Election.during_date(self.end_date)
      errors.add(:end_date, "cannot be during another election")
    end
  end
end
