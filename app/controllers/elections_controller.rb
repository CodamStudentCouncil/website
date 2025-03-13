class ElectionsController < ApplicationController
  before_action :logged_in_user
  before_action :very_secure_current_council_filter

  def index
    @elections = Election.all
  end

  def show
    @election = Election.find(params[:id])
  end

  def new
    @election = Election.new
  end

  def create
    @election = Election.new(election_params)

    if @election.save
      redirect_to @election
    else
      render "new"
    end
  end

  def edit
    @election = Election.find(params[:id])
  end

  def update
    @election = Election.find(params[:id])

    if @election.update(election_params)
      redirect_to @election
    else
      render "edit"
    end
  end

  def destroy
    @election = Election.find(params[:id])

    if @election.destroy
      redirect_to "index"
    else
      render @election
    end
  end

  private

  def election_params
    params.require(:election).permit(:start_date, :end_date)
  end

  def very_secure_current_council_filter
  end
end
