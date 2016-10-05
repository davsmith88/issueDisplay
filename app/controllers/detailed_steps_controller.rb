class DetailedStepsController < ApplicationController
  # authorize_resource
  # need to load and authorize both the resource and the parent resource
  load_and_authorize_resource :issue
  load_and_authorize_resource :detailed_step, :through => :issue

  before_action :set_issue_detailed_steps, except: [:show, :index]
  before_action :set_detailed_step, only: [:edit, :update, :destroy]
  before_action :set_issue, only: [:update]
  # before_action :find_issuse, only: [:index, :show, :create]

  # respond_to :html
  # respond_to :js, only: :create
  respond_to :js, only: [:index, :new, :create, :update, :edit]

  def index
    @issue = Issue.find(params[:id])
    @detailed_steps = @issue.detailed_steps.order(:number)
    @active_steps = true
    respond_to do |format|
      format.html
      # format.html {
        # render partial: "issues/show_step_table", layout: 'displaytab',locals: {list: @detailed_steps}}
      format.js
    end
  end

  def step_number_update
  # this method updates all the step numbers with the new step order 
  # performs a bulk update
  # Rails.logger.info @issue.inspect
  # Rails.logger.info @detailed_steps.inspect
  # Rails.logger.info flash.inspect
  

  data = params['params']

   DetailedStep.update(data.keys, data.values)
    respond_to do |format|
      format.json { render :nothing => true, :status => 200, :content_type => 'text/html'}
      # format.json { render "dd", :status => 200, :content_type => 'text/html'}
    end
  end

  def show
    # need to create an ajax response with relevant template ... think
    respond_to do |format|
      format.html 
      # format.js
    end

  end

  def quick_show
    # render "quick_show"
    @issue = Issue.find(params[:issue_id])
    @ds = @issue.detailed_steps.order(:number)

    respond_to do |format|
      format.js {}
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
    # @detailed_steps = @issue.detailed_steps.all
    respond_to do |format|
      if @detailed_step.save
        # format.html { redirect_to issues_path }
        puts @issue.inspect
        puts "===="
        @detailed_steps = @issue.detailed_steps.order(:number)
        format.html {redirect_to issue_path(@issue)}
        format.js { render action: 'index', format: :js }
        # format.js { index }
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
        @detailed_steps = @issue.detailed_steps.order(:number)
        puts "-----"
        puts "ttt"
        format.html {redirect_to issue_path(@issue), notice: "Detailed Step has been updated"}
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
      format.html {redirect_to issue_path(@issue)}
      format.js
    end

    # respond_with(@issue, @detailed_step, location: issue_detailed_steps_path(@issue))
  end

  private
    def set_issue
      @issue = Issue.find(params[:issue_id])
    end

    def set_issue_detailed_steps
      @issue = Issue.find(params[:issue_id])
      @detailed_steps = @issue.detailed_steps
    end

    def set_detailed_step
      @detailed_step = @detailed_steps.find(params[:id])
    end

    def detailed_step_params
      params.require(:detailed_step).permit(:number, :description)
    end
end
