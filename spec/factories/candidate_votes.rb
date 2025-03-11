FactoryBot.define do
  factory :candidate_vote do
    vote
    candidate

    in_favor { "yes" }

    before(:create) do |candidate_vote|
      election = create(:election)
      candidate_vote.vote.election = election
      candidate_vote.candidate.election = election
    end
  end
end
