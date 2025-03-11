require "rails_helper"

RSpec.describe CandidateVote, type: :model do
  it "should be valid with default attributes" do
    candidate_vote = build(:candidate_vote)
    expect(candidate_vote).to be_valid
  end

  it "should save with default attributes" do
    candidate_vote = build(:candidate_vote)
    expect(candidate_vote.save).to be_truthy
  end

  describe "candidate" do
    it "should not be nil" do
      candidate_vote = build(:candidate_vote, candidate: nil)
      expect(candidate_vote).to be_invalid
    end

    it "should belong to the same election as the vote" do
      candidate_vote = create(:candidate_vote)
      expect(candidate_vote).to be_valid

      candidate_vote.vote = build(:vote)
      expect(candidate_vote).to be_invalid
    end
  end

  describe "vote" do
    it "should not be nil" do
      candidate_vote = build(:candidate_vote, vote: nil)
      expect(candidate_vote).to be_invalid
    end

    it "should belong to the same election as the candidate" do
      candidate_vote = create(:candidate_vote)
      expect(candidate_vote).to be_valid

      candidate_vote.candidate = build(:candidate)
      expect(candidate_vote).to be_invalid
    end
  end

  describe "feedback" do
    it "can be blank" do
      candidate_vote = build(:candidate_vote, feedback: "")
      expect(candidate_vote).to be_valid
    end

    it "should become nil when blank" do
      candidate_vote = build(:candidate_vote, feedback: "")
      candidate_vote.save
      expect(candidate_vote.feedback).to eq(nil)
    end

    it "should become nil when whitespace" do
      candidate_vote = build(:candidate_vote, feedback: "         ")
      candidate_vote.save
      expect(candidate_vote.feedback).to eq(nil)
    end
  end
end
