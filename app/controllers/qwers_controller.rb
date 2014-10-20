class QwersController < ApplicationController
  before_action :set_qwer, only: [:show, :edit, :update, :destroy]

  # GET /qwers
  # GET /qwers.json
  def index
    @qwers = Qwer.all
  end

  # GET /qwers/1
  # GET /qwers/1.json
  def show
  end

  # GET /qwers/new
  def new
    @qwer = Qwer.new
  end

  # GET /qwers/1/edit
  def edit
  end

  # POST /qwers
  # POST /qwers.json
  def create
    @qwer = Qwer.new(qwer_params)

    respond_to do |format|
      if @qwer.save
        format.html { redirect_to @qwer, notice: 'Qwer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @qwer }
      else
        format.html { render action: 'new' }
        format.json { render json: @qwer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qwers/1
  # PATCH/PUT /qwers/1.json
  def update
    respond_to do |format|
      if @qwer.update(qwer_params)
        format.html { redirect_to @qwer, notice: 'Qwer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @qwer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qwers/1
  # DELETE /qwers/1.json
  def destroy
    @qwer.destroy
    respond_to do |format|
      format.html { redirect_to qwers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qwer
      @qwer = Qwer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qwer_params
      params.require(:qwer).permit(:name)
    end
end
