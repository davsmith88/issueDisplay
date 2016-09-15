class MediaController < ApplicationController

  authorize_resource

  before_action :get_department_area, except: [:create, :destroy]
  before_action :set_medium, only: [:show, :edit, :destroy]

  respond_to :html, except: [:create]

  def show
    respond_with(@medium)
  end

  def new
    # da = params[:department_area_id]
    # @images = Image.all
    @type = params[:type]
    @locations = Location.where(department_area_id: @da)
    @context = context
    puts "++"
    puts @context
    @medium = @context.build

    respond_to do |format|
      format.html
      format.js
    end
    # respond_with(@medium)
  end

  def create
    @context = context
    @medium = @context.create_medium(medium_params)
    @type = params[:type]
    if(@type == 'DetailedStep' || @type == 'Review')
      @issue = Issue.find(@context.issue_id)
    end
    respond_to do |format|
      format.html {redirect_to detailed_step_media_path(@dt)}
      format.js
      format.json {render :nothing => true, :status => 200, :content_type => 'text/html'}
    end
    # redirect_to detailed_step_media_path(@dt)
  end

  def destroy

    @medium.destroy #destroys the medium model from database
    redirect_to session.delete(:return_to)  # redirects to the path stored in the session and deletes session
  end


  private

    def get_department_area
      @da = DepartmentArea.find(params[:department_area_id])
    end

    def get_detailed_step
      @dt = DetailedStep.find(params[:detailed_step_id])
    end

    def set_medium
      @medium = Medium.find(params[:id])
    end

    def medium_params
      params.require(:medium).permit(:image_id)
    end

    def context
      id = params[:type_id]

      if params[:type] == 'DetailedStep'
        return DetailedStep.find(id)
      end
      if params[:type] == 'Location'
        return Location.find(id)
      end
      if params[:type] == 'Review'
        return Review.find(id)
      end
    end

    def context_path(context)
      if DetailedStep == context
        detailed_step_path(context)
      end
    end
end
