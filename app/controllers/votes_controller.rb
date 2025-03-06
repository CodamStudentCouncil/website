class VotesController < ApplicationController
  before_action :needs_current_election

  def new
    @election ||= Election.current
    @candidates = @election.candidates
    @votes = @candidates.map { |c| c.votes.new }
  end

  def create
  end

  private

  def needs_current_election
    return unless Election.current

    redirect_to root_url
  end

  def votes_params
    params.permit(:feedback, votes: [ :candidate_id, :in_favor, :comment ])
          .require(:votes)
  end
end
