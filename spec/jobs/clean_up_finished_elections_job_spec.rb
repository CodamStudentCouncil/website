require "rails_helper"

RSpec.describe CleanUpFinishedElectionsJob, type: :job do
  before(:example) do
    @today = Time.zone.now.to_date
    @past_election    = create(:election_with_votes, start_date: @today - 15, end_date: @today - 9)
    @current_election = create(:election_with_votes, start_date: @today - 6,  end_date: @today)
    @future_election  = create(:election_with_votes, start_date: @today + 3,  end_date: @today + 9)
  end

  it "should remove registrations from past elections" do
    expect { CleanUpFinishedElectionsJob.perform_now }
      .to change { @past_election.registrations.count }.from(5).to(0)
  end

  it "should not remove registrations from in-progress elections" do
    expect { CleanUpFinishedElectionsJob.perform_now }
      .not_to change { @current_election.registrations.count }
  end

  it "should not change registrations for future elections" do
    expect { CleanUpFinishedElectionsJob.perform_now }
      .not_to change { @future_election.registrations.count }
  end
end
