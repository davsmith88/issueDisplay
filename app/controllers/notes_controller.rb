class NotesController < ApplicationController
	def index
		@issue = Issue.find(params[:issue_id])
		@notes = @issue.notes.all
	end

	def show

	end

	def new
		@issue = Issue.find(params[:issue_id])
		@note = @issue.notes.new
	end

	def create
		@issue = Issue.find(params[:issue_id])
		@note = @issue.notes.new(note_params)

		

		@note.save
		redirect_to issue_notes_path(@issue)
	end

	def edit

	end

	def update

	end

	private

	def note_params
		params.require(:note).permit(:context, :category)
	end
end