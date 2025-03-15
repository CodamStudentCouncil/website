require "rails_helper"

RSpec.describe Candidate, type: :model do
  before(:example) do
    ENV["CAMPUS_ID"] = "14"
  end

  it "should be valid with default attributes" do
    candidate = build(:candidate)
    expect(candidate).to be_valid
  end

  describe "election" do
    it "should be present" do
      candidate = build(:candidate, election: nil)
      expect(candidate).to be_invalid
    end
  end

  describe "username" do
    it "should not be blank" do
      candidate = build(:candidate, username: "")
      expect(candidate).to be_invalid
    end

    it "should not be nil" do
      candidate = build(:candidate, username: nil)
      expect(candidate).to be_invalid
    end

    it "should not be too long" do
      candidate = build(:candidate, username: "a" * 12)
      expect(candidate).to be_invalid
    end

    it "should be unique within an election" do
      election = create(:election)
      create(:candidate, election: election, username: "hello")
      new_candidate = build(:candidate, election: election, username: "hello")

      expect(new_candidate).to be_invalid
    end

    it "should not be unique across different elections" do
      create(:candidate, username: "hello")
      candidate = build(:candidate, username: "hello")

      expect(candidate).to be_valid
    end
  end

  describe "full_name" do
    it "should be valid when blank" do
      candidate = build(:candidate, full_name: "")
      expect(candidate).to be_valid
    end

    it "should be valid when nil" do
      candidate = build(:candidate, full_name: nil)
      expect(candidate).to be_valid
    end
  end

  describe "photo_url" do
    it "should be valid when blank" do
      candidate = build(:candidate, photo_url: "")
      expect(candidate).to be_valid
    end

    it "should be valid when nil" do
      candidate = build(:candidate, photo_url: nil)
      expect(candidate).to be_valid
    end
  end

  describe "tagline" do
    it "should be valid when blank" do
      candidate = build(:candidate, tagline: "")
      expect(candidate).to be_valid
    end

    it "should be valid when nil" do
      candidate = build(:candidate, tagline: nil)
      expect(candidate).to be_valid
    end

    it "should not be too long" do
      candidate = build(:candidate, tagline: "a" * 200)
      expect(candidate).to be_invalid
    end
  end

  describe "motivation" do
    it "should be valid when blank" do
      candidate = build(:candidate, motivation: "")
      expect(candidate).to be_valid
    end

    it "should be valid when nil" do
      candidate = build(:candidate, motivation: nil)
      expect(candidate).to be_valid
    end

    # it "should not be too long" do
    #   candidate = build(:candidate, description: "a" * 500)
    #   expect(candidate).to be_invalid
    # end
  end

  describe "focus area" do
    it "should be valid when blank" do
      candidate = build(:candidate, focus_area: "")
      expect(candidate).to be_valid
    end

    it "should be valid when nil" do
      candidate = build(:candidate, focus_area: nil)
      expect(candidate).to be_valid
    end

    it "should not be too long" do
      candidate = build(:candidate, focus_area: "a" * 500)
      expect(candidate).to be_invalid
    end
  end

  describe "campus_ids" do
    it "should be valid with multiple campuses" do
      candidate = build(:candidate, campus_ids: [ 1, 14, 3 ])
      expect(candidate).to be_valid
    end

    it "should not be valid when empty" do
      candidate = build(:candidate, campus_ids: [])
      expect(candidate).to be_invalid
    end

    it "should not be valid when not containing our campus" do
      candidate = build(:candidate, campus_ids: [ 1, 2 ])
      expect(candidate).to be_invalid
    end

    it "should not be required when updating" do
      candidate = create(:candidate)
      candidate.tagline = "Something Else"
      candidate.campus_ids = nil
      expect(candidate).to be_valid
      expect(candidate.save).to be_truthy
    end
  end
end
