require 'spec_helper'

describe IssueWorkaroundsController do
	before(:all) do
		# User.delete_all
		FactoryGirl.create(:user, email: 'testing@testing.com')
		@user = User.where(email: 'testing@testing.com').first
		# pp @user
		@role = Role.create(name: 'admin')
		@assignment = FactoryGirl.create(:assignment, role_id: @role.id, user_id: @user.id)

		@issue = FactoryGirl.create(:issue)

		@issue_right = FactoryGirl.create(:right, resource: "issues", operation: "READ")
		@issue_grant = FactoryGirl.create(:grant, right_id: @issue_right.id, role_id: @role.id)
	end

	# describe "GET #index", focus: true do
	# 	before do
	# 		@issue = FactoryGirl.create(:issue, state: 'publish')
	# 		@issue_workaround = FactoryGirl.create(:issue_workaround, issue_id: @issue.id)
	# 	end
	# 	context "when the user is logged in" do
	# 		before do
	# 			sign_in @user
	# 		end
	# 		context "and the user has the 'read' issue" do
	# 			before do
	# 				@iw_right = FactoryGirl.create(:right, resource: "issue_workarounds", operation: "READ")
	# 				@iw_grant = FactoryGirl.create(:grant, right_id: @iw_right.id, role_id: @role.id)
	# 			end
	# 			it "will assign issue to @issue" do
	# 				get :index, issue_id: @issue.id
	# 				# expect(assigns(:issue)).to eq @issue
	# 			end
	# 			it "will list the issue workarounds for a given issue"
	# 			it "render the index template" do
	# 				get :index, issue_id: @issue.id
	# 				expect(response).to render_template :index
	# 			end
	# 		end
	# 	end
	# 	context "when the user is not logged in" do
	# 		it "redirects to the login page"
	# 	end
	# end

	# describe "GET #show" do

	# end

	describe "GET #new" do
		context "when the user is logged in" do
			before do
				sign_in @user
			end
			context "and has the 'create' right" do
				before do
					@iw_right_read = FactoryGirl.create(:right, resource: "issue_workarounds", operation: "READ")
					@iw_right_create = FactoryGirl.create(:right, resource: "issue_workarounds", operation: "CREATE")
					@iw_grant_create = FactoryGirl.create(:grant, role_id: @role.id, right_id: @iw_right_create.id)
					@iw_grant_read = FactoryGirl.create(:grant, role_id: @role.id, right_id: @iw_right_read.id)
					get :new, issue_id: @issue.id
				end
				it "will assign issue to @issue" do
					expect(assigns(:issue)).to eq @issue
				end
				it "assigns a new issue to @issue_workaround" do
					expect(assigns(:issue_workaround)).to be_a_new(IssueWorkaround)
				end
				it "renders the new template" do
					expect(response).to render_template :new
				end
			end
			context "and does not have the create right" do
				before do
					get :index, issue_id: @issue.id
				end
				it "redirects to the home page" do
					expect(response).to redirect_to home_path
				end
				it "does not render the new template" do
					expect(response).to_not render_template :new
				end
			end
		end
		context "when the user is not logged in" do
			before do
				get :index, issue_id: @issue.id
			end
			it "will not render the new template" do
				expect(response).to_not render_template :new
			end
			it "will redirect to the sign in page" do
				expect(response).to redirect_to new_user_session_path
			end
		end
	end

	describe "GET #edit" do
		before do
			@iw = FactoryGirl.create(:issue_workaround, issue_id: @issue.id)
		end
		context "and the user is logged in" do
			before do
				sign_in @user
			end
			context "and has the 'update' right" do
				before do
					@iw_right_read = FactoryGirl.create(:right, operation: "READ", resource: "issue_workarounds")
					@iw_grant_read = FactoryGirl.create(:grant, role_id: @role.id, right_id: @iw_right_read.id)

					@iw_right_update = FactoryGirl.create(:right, operation: "UPDATE", resource: "issue_workarounds")
					@iw_grant_update = FactoryGirl.create(:grant, role_id: @role.id, right_id: @iw_right_update.id)

					get :edit, issue_id: @issue.id, id: @iw.id
				end
				it "assigns workarounds to @issue_workarounds variable" do
					expect(assigns(:issue_workaround)).to eq @iw
				end
				it "renders the edit template" do
					expect(response).to render_template :edit
				end
				it "renders the edit template in the 'edit_page' layout" do
					pending
					expect(response).to render_with_layout 'edit_page'
				end
			end
			context "and does not have the 'update' right" do
				before do
					get :edit, issue_id: @issue.id, id: @iw.id
				end
				it "will not renders the edit template" do
					expect(response).to_not render_template :edit
				end
				it "will redirect to the home page" do
					expect(response).to redirect_to home_path
				end
			end
		end
		context "and the user is not logged in" do
			before do
				get :edit, issue_id: @issue.id, id: @iw.id
			end
			it "will not render the edit template" do
				expect(page).to_not render_template :edit
			end
			it "will redirect to the log in page" do
				expect(page).to redirect_to new_user_session_path
			end
		end
	end

	describe "POST #create" do
		before do
		end
		context "when the user is logged in" do
			before do
				sign_in @user
			end
			context "and the user has the create right" do
				before do
					@iw_right_read = FactoryGirl.create(:right, resource: "issue_workarounds", operation: "READ")
					@iw_grant_read = FactoryGirl.create(:grant, role_id: @role.id, right_id: @iw_right_read.id)

					@iw_right_create = FactoryGirl.create(:right, resource: "issue_workarounds", operation: "CREATE")
					@iw_grant_create = FactoryGirl.create(:grant, role_id: @role.id, right_id: @iw_right_create.id)

				end
				context "with valid attributes" do
					it "will create the issue workaround" do
						expect {
							post :create, issue_id: @issue, issue_workaround: FactoryGirl.attributes_for(:issue_workaround)
						}.to change(IssueWorkaround, :count).by(1)
					end
					it "redirects to the issue after save" do
						post :create, issue_id: @issue, issue_workaround: FactoryGirl.attributes_for(:issue_workaround)
						expect(response).to redirect_to edit_issue_path(@issue)
					end
					it "assigns the issue id to the workaround" do
						post :create, issue_id: @issue, issue_workaround: FactoryGirl.attributes_for(:issue_workaround)
						expect(assigns(:issue_workaround).issue_id).to eq @issue.id
					end
					it "returns the neccessary instance variables" do
						post :create, issue_id: @issue, issue_workaround: FactoryGirl.attributes_for(:issue_workaround)
						expect(assigns(:issue_workaround)).to_not be_nil
					end
					it "will have a flash message"
				end
				context "with invalid attributes" do
					it "will not create the issue workaround" do
						expect {
							post :create, issue_id: @issue, issue_workaround: FactoryGirl.attributes_for(:invalid_workaround)
						}.to change(Issue, :count).by(0)
					end
					it "renders the 'new' template" do
						post :create, issue_id: @issue, issue_workaround: FactoryGirl.attributes_for(:invalid_workaround)
						expect(response).to render_template :new
					end
					it "will return a flash message" do
						post :create, issue_id: @issue, issue_workaround: FactoryGirl.attributes_for(:invalid_workaround)
						expect(flash[:alert]).to eq "Issue Workaround could not be created - Invalid Attributes"
					end
				end
			end
			context "and the user does not have the create right" do
				it "will not create an issue" do
					expect {
						post :create, issue_id: @issue, issue_workaround: FactoryGirl.attributes_for(:invalid_workaround)
					}.to change(Issue, :count).by(0)
				end
				it "will redirect to the issue home page" do
					post :create, issue_id: @issue, issue_workaround: FactoryGirl.attributes_for(:invalid_workaround)
					expect(page).to redirect_to home_path
				end
			end
		end
		context "when the user is not logged in" do
			before do
				
			end
			it "does not create the workaround" do
				expect {
					post :create, issue_id: @issue, issue_workaround: FactoryGirl.attributes_for(:invalid_workaround)
				}.to change(Issue, :count).by(0)
			end
			it "will redirect to the home page" do
				post :create, issue_id: @issue, issue_workaround: FactoryGirl.attributes_for(:invalid_workaround)
				expect(response).to redirect_to new_user_session_path
			end
		end
	end

	describe "PATCH #update" do
		context "when the user is logged in" do
			before do
				sign_in @user
			end
			context "and has the 'update' right" do
				before do
					iw_read_right = FactoryGirl.create(:right, resource: "issue_workarounds", operation: "READ")
					iw_read_grant = FactoryGirl.create(:grant, role_id: @role.id, right_id: iw_read_right.id)

					iw_update_right = FactoryGirl.create(:right, resource: "issue_workarounds", operation: "UPDATE")
					iw_update_grant = FactoryGirl.create(:grant, role_id: @role.id, right_id: iw_update_right.id)
				end
				context "with valid attributes" do
					before do
						@workaround = FactoryGirl.create(:issue_workaround, description: "starting description", issue_id: @issue.id)
						patch :update, issue_id: @issue.id, id: @workaround.id, issue_workaround: FactoryGirl.attributes_for(:issue_workaround, description: "different workaround")
					end
					it "will get the issue workaround" do
						expect(assigns(:issue_workaround)).to eq(@workaround)
					end
					it "will update the issue" do
						expect(assigns(:issue_workaround).description).to eq "different workaround"
						expect(assigns(:issue_workaround).description).to_not eq "starting description"
					end
					it "will return a flash message" do
						expect(flash[:notice]).to eq "Workaround has been updated"
					end
					it "will return the neccessary instance variable" do
						expect(assigns(:issue_workaround)).to_not be_nil
					end
					it "redirect to the issue after save" do
						expect(response).to redirect_to edit_issue_path(@issue)
					end
				end
				context "with invalid attrbutes" do
					before do
						sign_in @user
						@workaround = FactoryGirl.create(:issue_workaround, issue_id: @issue.id)
						@workaround_invalid = FactoryGirl.attributes_for(:invalid_workaround)
						patch :update, issue_id: @issue.id, id: @workaround, issue_workaround: @workaround_invalid
					end
					it "will return the invalid attributes to edit" do
						expect(assigns(:issue_workaround).description).to eq @workaround_invalid[:description]
					end
					it "will not update the issue workaround" do
						expect(assigns(:issue_workaround).description).to_not eq @workaround.description
					end
					it "will render the edit template" do
						expect(response).to render_template :edit
					end
					it "will return a flash message" do
						expect(flash[:alert]).to eq "Workaround could not be saved"
					end
				end
			end
			context "and does not the have update right" do
				before do
					sign_in @user
					@workaround = FactoryGirl.create(:issue_workaround, issue_id: @issue.id, description: "hello world")
					@workaround_invalid = FactoryGirl.attributes_for(:invalid_workaround)
					patch :update, issue_id: @issue.id, id: @workaround, issue_workaround: @workaround_invalid
				end
				it "will not update the workaround" do
					@workaround.reload
					expect(@workaround.description).to eq "hello world"
				end
				it "will redirect to the home page" do
					expect(response).to redirect_to home_path
				end
			end
		end
		context "when the user is not logged in" do
			before do
				@workaround = FactoryGirl.create(:issue_workaround, issue_id: @issue.id, description: "hello world")
				@workaround_invalid = FactoryGirl.attributes_for(:invalid_workaround)
				patch :update, issue_id: @issue.id, id: @workaround, issue_workaround: @workaround_invalid
			end
			it "does not update the workaround" do
				@workaround.reload
				expect(@workaround.description).to eq "hello world"
			end
			it "redirects to the home page" do
				expect(response).to redirect_to new_user_session_path
			end
		end
	end

	describe "DELETE #destroy" do
		context "when the user is logged in" do
			before do
				sign_in @user
			end
			context "with the 'delete' right" do
				before do
					iw_right_read = FactoryGirl.create(:right, operation: "READ", resource: "issue_workarounds")
					iw_grant_read = FactoryGirl.create(:grant, role_id: @role.id, right_id: iw_right_read.id)

					iw_right_destroy = FactoryGirl.create(:right, operation: "DESTROY", resource: "issue_workarounds")
					iw_grant_destroy = FactoryGirl.create(:grant, role_id: @role.id, right_id: iw_right_destroy.id)
	
					@workaround = FactoryGirl.create(:issue_workaround, issue_id: @issue.id)
				end
				it "will delete issue workaround" do
					expect {
						delete :destroy, id: @workaround
					}.to change(IssueWorkaround, :count).by(-1)
				end
				it "will display a flash message" do
					delete :destroy, id: @workaround
					expect(flash[:notice]).to eq "Issue Workaround has been deleted"
				end
				it 'redirects to the issue page' do
					delete :destroy, id: @workaround
					expect(response).to redirect_to edit_issue_path(@issue)
				end
			end
			context "without the 'delete' right" do
				before do
					@workaround = FactoryGirl.create(:issue_workaround, issue_id: @issue.id)
				end
				it "will not delete the issue workarond" do
					expect{
						delete :destroy, id: @workaround
					}.to change(Issue, :count).by(0)
				end
				it "will redirect to the home page" do
					delete :destroy, id: @workaround
					expect(response).to redirect_to home_path
				end
			end
		end
		context "when the user is NOT logged in" do
			before do
				@workaround = FactoryGirl.create(:issue_workaround, issue_id: @issue)
			end
			it "will not delete the issue" do
				expect {
					delete :destroy, id: @workaround
				}.to change(IssueWorkaround, :count).by(0)
			end
			it "will redirect to the sign in page" do
				delete :destroy, id: @workaround
				expect(response).to redirect_to new_user_session_path
			end
		end
	end
end