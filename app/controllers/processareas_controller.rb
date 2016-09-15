class ProcessareasController < ApplicationController
  before_action :set_processarea, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @processareas = Processarea.all
    respond_with(@processareas)
  end

  def show
    respond_with(@processarea)
  end

  def new
    @processarea = Processarea.new
    respond_with(@processarea)
  end

  def edit
  end

  def create
    @processarea = Processarea.new(processarea_params)
    @processarea.save
    respond_with(@processarea)
  end

  def update
    @processarea.update(processarea_params)
    respond_with(@processarea)
  end

  def destroy
    @processarea.destroy
    respond_with(@processarea)
  end

  private
    def set_processarea
      @processarea = Processarea.find(params[:id])
    end

    def processarea_params
      params.require(:processarea).permit(:complaint_id, :process_area_type)
    end
end
