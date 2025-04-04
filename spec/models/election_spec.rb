require "rails_helper"

RSpec.describe Election, type: :model do
  it "should be valid with default attributes" do
    election = build(:election)
    expect(election).to be_valid
  end

  describe "start_date" do
    it "should not be blank" do
      election = build(:election, start_date: "")
      expect(election).to be_invalid
    end

    it "should not be nil" do
      election = build(:election, start_date: nil)
      expect(election).to be_invalid
    end
  end

  describe "end_date" do
    it "should not be blank" do
      election = build(:election, end_date: "")
      expect(election).to be_invalid
    end

    it "should not be nil" do
      election = build(:election, end_date: nil)
      expect(election).to be_invalid
    end

    it "should not be before start date" do
      election = build(:election)
      election.end_date = election.start_date - 1
      expect(election).to be_invalid
    end

    it "should not be equal to start date" do
      election = build(:election)
      election.end_date = election.start_date
      expect(election).to be_invalid
    end
  end

  describe "current election" do
    it "should include elections that start today" do
      create(:election, start_date: Time.zone.now.to_date, end_date: Time.zone.now.to_date + 7)
      expect(Election.current).to be_truthy
    end

    it "should include elections that end today" do
      create(:election, start_date: Time.zone.now.to_date - 7, end_date: Time.zone.now.to_date)
      expect(Election.current).to be_truthy
    end

    it "should not include elections that start tomorrow" do
      create(:election, start_date: Time.zone.now.to_date + 1, end_date: Time.zone.now.to_date + 8)
    end

    it "should not include elections that end yesterday" do
      create(:election, start_date: Time.zone.now.to_date - 8, end_date: Time.zone.now.to_date - 1)
    end

    it "should be nil if there is no current election" do
      create(:election, start_date: Time.zone.now.to_date + 3, end_date: Time.zone.now.to_date + 11)
      expect(Election.current).to be_falsy
    end

    it "should be nil if there are no elections" do
      expect(Election.current).to be_falsy
    end
  end

  describe "in_progress?" do
    before(:context) do
      @today = Time.zone.now.to_date
    end

    it "should be true if the current date is between the start and end date" do
      election = create(:election, start_date: @today - 3, end_date: @today + 4)
      expect(election.in_progress?).to be_truthy
    end

    it "should be true if the current date is the start date" do
      election = create(:election, start_date: @today, end_date: @today + 3)
      expect(election.in_progress?).to be_truthy
    end

    it "should be true if the current date is the end date" do
      election = create(:election, start_date: @today - 7, end_date: @today)
      expect(election.in_progress?).to be_truthy
    end

    it "should be false if the current date is before the start date" do
      election = create(:election, start_date: @today + 1, end_date: @today + 8)
      expect(election.in_progress?).to be_falsy
    end

    it "should be false if the current date is after the end date" do
      election = create(:election, start_date: @today - 8, end_date: @today - 1)
      expect(election.in_progress?).to be_falsy
    end
  end

  describe "clean_up_registrations!" do
    context "with an in-progress election" do
      before(:example) do
        @election = create(
          :election_with_votes,
          start_date: Time.zone.now.to_date - 3,
          end_date: Time.zone.now.to_date + 3
        )
      end

      it "should raise an error" do
        expect { @election.clean_up_registrations! }
          .to raise_error(Election::ElectionInProgressError)
      end

      it "should not remove registrations" do
        expect { @election.clean_up_registrations! rescue Election::ElectionInProgressError }
          .not_to change(@election, :registrations)
      end
    end

    context "with a finished election" do
      before(:example) do
        @election = create(:election_with_votes)
      end

      it "should reduce registration count to zero" do
        expect { @election.clean_up_registrations! }
          .to change(@election.registrations, :count).from(5).to(0)
      end

      it "should not change votes" do
        expect { @election.clean_up_registrations! }
          .not_to change { @election.votes }
      end

      it "should not change vote count" do
        expect { @election.clean_up_registrations! }
          .not_to change(@election.votes, :count)
      end
    end
  end

  describe "finalized" do
    it "should be false by default" do
      election = create(:election)
      expect(election.reload.finalized).to eq(false)
    end
  end

  describe "to_be_finalized?" do
    it "should be true if finalized is false and the election is over" do
      election = create(:election, finalized: false, start_date: Time.zone.now.to_date - 8, end_date: Time.zone.now.to_date - 1)
      expect(election.to_be_finalized?).to eq(true)
    end

    it "should be false if the election is in progress" do
      election = create(:election, finalized: true, start_date: Time.zone.now.to_date - 3, end_date: Time.zone.now.to_date + 4)
      expect(election.to_be_finalized?).to eq(false)
    end

    it "should be false if the election is in the future" do
      election = create(:election, finalized: true, start_date: Time.zone.now.to_date + 1, end_date: Time.zone.now.to_date + 8)
      expect(election.to_be_finalized?).to eq(false)
    end

    it "should be false if the election is over and has already been finalized" do
      election = create(:election, finalized: true, start_date: Time.zone.now.to_date - 8, end_date: Time.zone.now.to_date - 1)
      expect(election.to_be_finalized?).to eq(false)
    end
  end

  describe "finished?" do
    it "should be false if the election is upcoming" do
      election = create(:election, start_date: Time.zone.now.to_date + 1, end_date: Time.zone.now.to_date + 8)
      expect(election.finished?).to be_falsy
    end

    it "should be false if the election is in progress" do
      election = create(:election, start_date: Time.zone.now.to_date - 3, end_date: Time.zone.now.to_date + 3)
      expect(election.finished?).to be_falsy
    end

    it "should be true if the election is over" do
      election = create(:election, start_date: Time.zone.now.to_date - 8, end_date: Time.zone.now.to_date - 1)
      expect(election.finished?).to be_truthy
    end

    it "should be false if this is the last day of the election" do
      election = create(:election, start_date: Time.zone.now.to_date - 8, end_date: Time.zone.now.to_date)
      expect(election.finished?).to be_falsy
    end
  end
end
