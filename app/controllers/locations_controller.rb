class LocationsController < ApplicationController

  authorize_resource

  before_action :get_department_area, only: [:index, :new, :create, :destroy, :edit, :update]
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @locations = @da.locations
    # @locations = Location.al
    render layout: 'admin_layout'
    # respond_with(@locations)
  end

  def show
    render layout: 'admin_layout'
    # respond_with(@location)
  end

  def new
    @location = @da.locations.new
    # respond_with(@location)
    render layout: 'admin_layout'
  end

  def edit
    render layout: 'admin_layout'
  end

  def create
    @location = @da.locations.new(location_params)
    # flash[:notice] = 'Location was successfully created.' if @location.save
    # render layout: 'admin_layout'
    respond_to do |format|
      if @location.save
        format.html {redirect_to department_area_locations_path(@da)}
      else
        format.html {render layout: 'admin_layout', action: 'new'}
      end
    end
    # redirect_to department_area_locations_path(@da)
  end

  def update
    flash[:notice] = 'Location was successfully updated.' if @location.update(location_params)
    # respond_with(@location)
    redirect_to department_area_locations_path(@da)
  end

  def destroy
    @location.destroy
    # respond_with(@location)
    redirect_to department_area_locations_path(@da.id)
  end

  private

    def get_department_area
      @da = DepartmentArea.find(params[:department_area_id])
    end

    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:code, :name, :info)
    end
end
