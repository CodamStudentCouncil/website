require 'rails_helper'

RSpec.describe CleanUpOldElectionsJob, type: :job do
  before(:example) do
    @today = Time.zone.now.to_date
    @really_old_election = create(:election_with_votes, start_date: @today - 1.year - 90, end_date: @today - 1.year - 80)
    @old_election = create(:election_with_votes, start_date: @today - 1.year - 30, end_date: @today - 1.year - 25)
    @half_old_election = create(:election_with_votes, start_date: @today - 1.year - 4, end_date: @today - 1.year + 3)
    @not_that_old_election = create(:election_with_votes, start_date: @today - 1.year + 30, end_date: @today - 1.year + 40)
  end

  it "should remove elections that ended over a year ago" do
    expect { CleanUpOldElectionsJob.perform_now }
      .to change { Election.exists?(@really_old_election.id) }
  end

  it "should remove all elections that ended over a year ago" do
    expect { CleanUpOldElectionsJob.perform_now }
      .to change { Election.count }.from(4).to(2)
  end

  it "should not remove elections that ended less than a year ago" do
    expect { CleanUpOldElectionsJob.perform_now }
      .not_to change { Election.exists?(@half_old_election.id) }
  end

  it "should not remove elections that started less than a year ago" do
    expect { CleanUpOldElectionsJob.perform_now }
      .not_to change { Election.exists?(@not_that_old_election.id) }
  end

  it "should also delete associated votes" do
    expect { CleanUpOldElectionsJob.perform_now }
      .to change { Vote.count }.from(20).to(10)
  end
end
