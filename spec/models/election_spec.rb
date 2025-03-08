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
end
