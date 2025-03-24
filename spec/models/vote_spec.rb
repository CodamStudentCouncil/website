require "rails_helper"

RSpec.describe Vote, type: :model do
  it "should be valid with default attributes" do
    vote = build(:vote)
    expect(vote).to be_valid
  end

  it "should save with default attributes" do
    vote = build(:vote)
    expect(vote.save).to be_truthy
  end

  describe "election" do
    it "should be present" do
      vote = build(:vote, election: nil)
      expect(vote).to be_invalid
    end
  end

  describe "feedback" do
    it "can be blank" do
      vote = build(:vote, feedback: "")
      expect(vote).to be_valid
    end

    it "should become nil when blank" do
      vote = build(:vote, feedback: "")
      vote.save
      expect(vote.feedback).to eq(nil)
    end

    it "should become nil when whitespace" do
      vote = build(:vote, feedback: "         ")
      vote.save
      expect(vote.feedback).to eq(nil)
    end

    it "should not be too long" do
      vote = build(:vote, feedback: "a" * 5000)
      expect(vote).to be_invalid
    end
  end
end
