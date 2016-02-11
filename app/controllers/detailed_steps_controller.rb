class DetailedStepsController < ApplicationController
  authorize_resource
  before_action :set_issue_detailed_steps, except: [:show, :index]
  before_action :set_detailed_step, only: [:edit, :update, :destroy]
  # before_action :find_issuse, only: [:index, :show, :create]

  respond_to :html
  # respond_to :js, only: :create

  def index
    @issue = Issue.find(params[:id])
    @detailed_steps = @issue.detailed_steps
    @active_steps = true
    respond_to do |format|
      format.html {
        render partial: "issues/show_step_table", layout: 'displaytab',locals: {list: @detailed_steps}}
      format.js
    end
  end

  def show
    # need to create an ajax response with relevant template ... think
    respond_to do |format|
      format.html 
      # format.js
    end

  end

  def new
    @detailed_step = @detailed_steps.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @issue = Issue.find(params[:issue_id])
    @detailed_step = @detailed_steps.new(detailed_step_params)
    @detailed_step.save
    @detailed_steps = @detailed_steps.all
    respond_to do |format|
      if @detailed_step.save
        format.html {redirect_to issue_detailed_steps_path(@issue)}
        format.js
      else
        flash.now[:alert] = "Issue is not valid"
        format.html {render action: 'new'}
        format.js {render action: 'new'}
      end
    end
  end

  def update
    # @detailed_step.update(detailed_step_params)
    respond_to do |format|
      if @detailed_step.update(detailed_step_params)
        format.html {redirect_to @detailed_step, notice: "Detailed Step has been updated"}
        format.js
      else
        format.html
        format.js
      end
    end
    # respond_with(@issue, @detailed_step, location: issue_detailed_steps_path(@issue))
  end

  def destroy
    @detailed_step.destroy

    respond_to do |format|
      format.html {redirect_to issue_detailed_steps_path(@issue)}
      format.js
    end

    # respond_with(@issue, @detailed_step, location: issue_detailed_steps_path(@issue))
  end

  private
    def set_issue_detailed_steps
      @issue = Issue.find(params[:issue_id])
      @detailed_steps = @issue.detailed_steps
    end

    def set_detailed_step
      @detailed_step = @detailed_steps.find(params[:id])
    end

    def detailed_step_params
      params.require(:detailed_step).permit(:number, :description, :image)
    end
end
