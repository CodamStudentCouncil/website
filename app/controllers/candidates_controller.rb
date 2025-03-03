class CandidatesController < ApplicationController
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
      redirect_to @election
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
      redirect_to @candidate
    else
      render "edit"
    end
  end

  def destroy
    @candidate = Election.find(params[:election_id])&.candidates.find(params[:id])

    if @candidate.destroy
      redirect_to @election
    else
      render @candidate, status: :bad_request
    end
  end

  private

  def candidate_create_params
    params.require(:candidate).permit(:username)
  end

  def candidate_params
    params.require(:candidate).permit(:focus_area, :description)
  end
end
