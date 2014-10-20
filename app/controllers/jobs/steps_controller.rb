class Jobs::StepsController < ApplicationController
	def index
		@job = Job.find(params[:job_id])
		@steps = Step.where(job_id: params[:job_id]).order(:step_order)
	end

	def show
		
	end

	def new
		
		@job = Job.find(params[:job]) || @step.job_id
		@step = Step.new
	end

	def edit
		@job = Job.find(params[:job])
		@step = Step.find(params[:id])
	end

	def create
		@job = Job.find(params['step'][:job_id])
		@step = Step.new(steps_params)



		if params[:step].has_key? :picture
			puts "--> has image"
			@image = @step.images.new(image_params)
			@image.save
		end


		respond_to do |format|
			if @step.save
				format.html { redirect_to jobs_steps_path(job_id: @step.job_id), notice: "step has been created" }
			else
				format.html {render action: 'new'}
			end
		end
	end

	def update
		@step = Step.find(params[:id])

		if params[:step].has_key? :picture
			puts "--> has image"
			@step.images.destroy_all
			@image = @step.images.new(image_params)
			@image.save
		end

		respond_to do |format|
			if @step.update(steps_params)
				puts "here we go"
				format.html {redirect_to jobs_steps_path(job_id: @step.job_id)}
			else
				format.html {render action: 'edit'}
			end
		end
	end

	def destroy
		@step = Step.find(params[:id])
		@job = @step.job_id
		respond_to do |format|
			if @step.destroy
				format.html {redirect_to jobs_steps_path(job_id: @job), notice: "Step was deleted"}
			else
				format.html {redirect_to edit_jobs_step_path(@step), notice: "the step could not be deleted"}
			end
		end
	end

	private

	def image_params
		params.require(:step).permit(:picture)
	end

	def steps_params
		params.require(:step).permit(:description, :step_order, :job_id)
	end
end