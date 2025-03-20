class ResultsController < ApplicationController
  before_action :logged_in_user
  before_action :election_should_be_over, only: [ :show ]

  def index
    @elections = Election.where("end_date < ?", Time.zone.now.to_date)
  end

  def show
    @election ||= Election.find(params[:id])
  end

  private

  def election_should_be_over
    @election ||= Election.find(params[:id])

    return if @election.finished?

    flash[:error] = "The results for this election will become available when it is over."
    redirect_back_or_to results_url
  end
end
