class Jobs::JobsController < ApplicationController
	def index
		# puts params
		@department_area = DepartmentArea.where(department_id: params[:department], area_id: params[:area])
		@jobs = Job.where(department_area_id: @department_area.first.id)
	end

	def new
		@job = Job.new
		@depAreas = DepartmentArea.all.includes(:department, :area)
		respond_to do |format|
			format.html {render action: 'new'}
		end
	end

	def show
		@job = Job.find(params[:id])
	end

	def edit
		@job = Job.find(params[:id])
		@depAreas = DepartmentArea.all.includes(:department, :area)
	end

	def create
		@depAreas = DepartmentArea.all.includes(:department, :area)
		@job = Job.new(jobs_params)
		respond_to do |format|
			if @job.save
				format.html {redirect_to jobs_job_path(@job), notice: "job successfully created"}
			else
				format.html {render action: 'new'}
			end
		end
	end

	def update
		@depAreas = DepartmentArea.all.includes(:department, :area)
		@job = Job.find(params[:id])
		respond_to do |format|
			if @job.update(jobs_params)
				format.html {redirect_to jobs_job_path(@job), notice: "job has been updated"}
			else
				foramt.html {render action: "edit"}
			end
		end
	end

	def destroy
		@job = Job.find(params[:id])

		department = @job.department_area.department.id
		area = @job.department_area.area.id

		respond_to do |format|
			if @job.destroy
				format.html {redirect_to jobs_jobs_path(department: department, area: area), notice: "Job has been destroyed"}
			else
				format.html {redirect_to jobs_jobs_path, notice: "job could not be destroyed"}
			end
		end
	end

	private

	def jobs_params
		params.require(:job).permit(:name, :description, :department_area_id, :category)
	end
end