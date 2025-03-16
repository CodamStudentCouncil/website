class VotesController < ApplicationController
  before_action :needs_current_election
  before_action :log_in_to_vote,    except: [ :landing, :success ]
  before_action :no_duplicate_vote, except: :success

  def landing
    if logged_in?
      @election ||= Election.current
      @candidates = @election.candidates
    else
      render "login"
    end
  end

  def new
    @election ||= Election.current
    @candidates = @election.candidates
    @vote = @election.votes.new
    @candidates.each do |c|
      @vote.candidate_votes.build(candidate: c)
    end
  end

  def create
    @election ||= Election.current
    @candidates = @election.candidates
    @vote = @election.votes.new(vote_params)

    # Registering the voter and saving their vote is a single transaction
    # so that if either one fails, neither will be saved to the database.
    @vote.transaction do
      if @vote.save && @election.registrations.create(username: session[:username])
        redirect_to votes_success_url
      else
        render "new", status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end
  end

  def success
  end

  private

  def needs_current_election
    @election ||= Election.current
    return if @election

    flash[:warning] = "There is no election going right now, so you cannot vote."
    redirect_to root_url
  end

  def log_in_to_vote
    return if logged_in?

    flash[:info] = "You need to log in in order to vote!"
    redirect_to vote_url
  end

  def vote_params
    params.require(:vote).permit(:feedback, candidate_votes_attributes: [
      :id, :candidate_id, :in_favor, :feedback
    ])
  end

  def no_duplicate_vote
    @election ||= Election.current
    return unless @election.registrations.find_by_username(session[:username])

    flash[:error] = "You have already voted in this election."
    redirect_to root_url
  end
end
