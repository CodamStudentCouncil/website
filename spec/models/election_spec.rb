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
end
