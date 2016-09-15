class LineupsController < ApplicationController
  authorize_resource
  before_action :set_lineup, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @lineups = Lineup.all
    respond_with(@lineups)
  end

  def show
    respond_with(@lineup)
  end

  def new
    @lineup = Lineup.new
    respond_with(@lineup)
  end

  def edit
  end

  def create
    @lineup = Lineup.new(lineup_params)
    @lineup.save
    respond_with(@lineup)
  end

  def update
    @lineup.update(lineup_params)
    respond_with(@lineup)
  end

  def destroy
    @lineup.destroy
    respond_with(@lineup)
  end

  private
    def set_lineup
      @lineup = Lineup.find(params[:id])
    end

    def lineup_params
      params.require(:lineup).permit(:position_number, :job_number, :master_spec, :machine, :cust_name)
    end
end
