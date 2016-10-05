class ProblemsController < ApplicationController
  load_and_authorize_resource
  before_action :set_problem, only: [:show, :edit, :update, :destroy]

  # GET /problems
  # GET /problems.json
  def index
    @problems = Item.where(type_type: "Problem").all
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
    # this will show the list of issues related to the problem
    @issues = ProblemIssue.includes(:issue, :problem).where(problem_id: @problem)
  end

  # GET /problems/new
  def new
    # @item = Item.new
    @problem = Problem.new
    @item = @problem.item
    @depareas = DepartmentArea.pluck(:name, :id)
  end

  # GET /problems/1/edit
  def edit
      @item = @problem.item
     @depareas = DepartmentArea.pluck(:name, :id)
  end

  # POST /problems
  # POST /problems.json
  def create
    @depareas = DepartmentArea.pluck(:name, :id)
    @problem = Problem.new(item_params)

    respond_to do |format|
      if @problem.save
        format.html { redirect_to @problem, notice: 'Problem was successfully created.' }
        format.json { render action: 'show', status: :created, location: @problem }
      else
        format.html { render action: 'new' }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problems/1
  # PATCH/PUT /problems/1.json
  def update
    @item = Item.find(@problem.item.id)

    respond_to do |format|
      # @problem.update(item_params)
      # @item.update(item_params)
      # if @problem.update(problem_params)
      if @problem.update(item_params)
        format.html { redirect_to @problem, notice: 'Problem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    @problem.destroy
    respond_to do |format|
      format.html { redirect_to problems_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def problem_params
      params.require(:problem).permit(:name)
    end

    def item_params
      # params.require(:problem).permit(:name, :description, :department_area_id)
      params.require(:problem).permit(item_attributes: [:name, :description, :department_area_id])
    end
end
