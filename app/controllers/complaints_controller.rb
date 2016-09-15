class ComplaintsController < ApplicationController

	authorize_resource

	def index
		@complaints = Complaint.all.paginate(:page => params[:page])
		render layout: 'admin_layout'
	end

	def show
		# soon: add suport for location of lineups
		e = Lineup.last.timestamp
		@lineups = Lineup.where(machine: params[:machine_code], timestamp: e).order(position_number: :asc)
		@a = @lineups.group_by(&:master_spec)
		q = []
		@cust = [];
		@lineups.each do |l|
			q.push(l.master_spec)
			@cust.push(l.cust_name)
		end	
		type = get_step(params[:machine_code])
		# @complaints = Complaint.where(master_spec: q, step: params[:machine_code]).group_by(&:master_spec)
		@complaints = Complaint.where(master_spec: q, step: type).group_by(&:master_spec)
		@other = Complaint.where(cust_name: @cust).where.not(master_spec: q).group_by(&:cust_name)
		@change = []

		@lineups.each do |value|
			a = Hash.new
			a[:lineup] = value
			# @change.push(a)
			a[:complaints] = @complaints[value[:master_spec]]
			@change.push(a)
		end

		# @a.merge!(@complaints){|key,oldval,newval| [*oldval].to_a + [*newval].to_a }





	end

	def new
		@complaint = Complaint.new
		respond_to do |format|
			format.html { render action: 'new', layout: 'admin_layout'}
		end
	end

	def create
		@complaint = Complaint.new(complaint_params)
		respond_to do |format|
			if @complaint.save
				format.html {redirect_to complaints_path}
			else
				format.html {render action: "new"}
			end
		end
	end

	def edit
		@complaint = Complaint.find(params[:id])
		render layout: 'admin_layout'
	end

	def update
		@complaint = Complaint.find(params[:id])
		respond_to do |format|
			if @complaint.update(complaint_params)
				format.html { redirect_to complaints_path }
			else
				format.html { render action: 'edit' }
			end
		end
	end

	def destroy
		@complaint = Complaint.find(params[:id])
		respond_to do |format|
			if @complaint.delete
				format.html { redirect_to complaints_path }
			end
		end
	end

private

	def complaint_params
		params.require(:complaint).permit(:name, :description, :priority, :rectify, :master_spec, :internal, :step, :cust_name)
	end

	def get_step(machine)
		case machine
		when "35", "40"
			return "corrugator"
		when "150", "160", "170", "190", "180"
			return "flexo"
		when "230", "200", "260", "250", "240"
			return "diecut"
		else
			return "w"
		end 
	end

	
end