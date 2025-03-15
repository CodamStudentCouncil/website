class CandidatesController < ApplicationController
  before_action :logged_in_user
  before_action :very_secure_current_council_filter

  def show
    @election ||= Election.find(params[:election_id])
    @candidate = @election.candidates.find(params[:id])
  end

  def new
    @election ||= Election.find(params[:election_id])
    @candidate = @election.candidates.new
  end

  def create
    @election ||= Election.find(params[:election_id])
    @candidate = @election.candidates.new(candidate_create_params)

    if @candidate.save
      respond_to do |format|
        format.html { redirect_to @election }
        format.turbo_stream
      end
    else
      render "new"
    end
  end

  def edit
    @election ||= Election.find(params[:election_id])
    @candidate = @election.candidates.find(params[:id])
  end

  def update
    @election ||= Election.find(params[:election_id])
    @candidate = @election.candidates.find(params[:id])

    if @candidate.update(candidate_params)
      redirect_to @election
    else
      render "edit"
    end
  end

  def destroy
    @election ||= Election.find(params[:election_id])
    @candidate = @election.candidates.find(params[:id])

    @candidate.destroy

    respond_to do |format|
      format.html { redirect_to @election }
      format.turbo_stream
    end
  end

  private

  def candidate_create_params
    params.require(:candidate).permit(:username)
  end

  def candidate_params
    params.require(:candidate).permit(:tagline, :motivation, :focus_area)
  end
end
