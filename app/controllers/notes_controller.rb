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

		@note.version_number = @issue.versions.length
		@note.checked = false
		@note.author_read = false

		@note.save
		redirect_to issue_notes_path(@issue)
	end

	def edit

	end

	def update

	end

	def mark_as_checked
		@issue = Issue.find(params[:issue_id])
		@note = @issue.notes.find(params[:note_id])

		@note.checked = true
		@note.save
		redirect_to issue_notes_path(@issue)
	end

	def mark_as_user_read
		@issue = Issue.find(params[:issue_id])
		@note = @issue.notes.find(params[:note_id])
		if current_user.id == @issue.user_id
			@note.author_read = true
			@note.save
		else
			return redirect_to issue_notes_path(@issue), notice: "User is not the author id, cannot mark as read"
		end

		redirect_to edit_issue_path(@issue)
	end

	private

	def note_params
		params.require(:note).permit(:context, :category)
	end
end