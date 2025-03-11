require "rails_helper"

RSpec.describe Registration, type: :model do
  it "should be valid with default attributes" do
    registration = build(:registration)
    expect(registration).to be_valid
  end

  it "should save with default attributes" do
    registration = build(:registration)
    expect(registration.save).to be_truthy
  end

  describe "election" do
    it "should not be nil" do
      registration = build(:registration, election: nil)
      expect(registration).to be_invalid
    end
  end

  describe "username" do
    it "should not be blank" do
      registration = build(:registration, username: "")
      expect(registration).to be_invalid
    end

    it "should not be nil" do
      registration = build(:registration, username: nil)
      expect(registration).to be_invalid
    end

    it "should be unique within an election" do
      election = create(:election)
      create(:registration, election: election, username: "asdf")

      second_registration = build(:registration, election: election, username: "asdf")
      expect(second_registration).to be_invalid
    end

    it "should not need to be unique across different elections" do
      create(:registration, username: "asdf")
      registration = build(:registration, username: "asdf")

      expect(registration).to be_valid
    end
  end
end
