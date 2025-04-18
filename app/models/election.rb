class Election < ApplicationRecord
  has_many :candidates, -> { order(username: :asc) }, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates_presence_of :start_date, :end_date
  validates :end_date, comparison: { greater_than: :start_date }

  default_scope { includes(:candidates) }


  def self.current
    self.during_date(Time.zone.now.to_date)
  end

  def self.during_date(date)
    Election.where("start_date <= ?", date)
            .where("end_date >= ?", date)
            .limit(1)
            &.take
  end

  def finished?
    Time.zone.now.to_date > self.end_date
  end

  def in_progress?
    Time.zone.now.to_date >= self.start_date && Time.zone.now.to_date <= self.end_date
  end

  def to_be_finalized?
    Time.zone.now.to_date > self.end_date && !self.finalized
  end

  def votes_with_feedback
    self.votes.where.not(feedback: nil)
  end

  def clean_up_registrations!
    raise ElectionInProgressError,
      "Cannot delete registrations while election is in progress" if self.in_progress?

    self.transaction do
      self.registrations.destroy_all
    end
  end

  class ElectionInProgressError < StandardError
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
