require 'spec_helper'
# adds tests for instance variables

describe IssuesController do
	before :all do
		@business1 = FactoryGirl.create(:business)
		@business = FactoryGirl.create(:business)
		@user = FactoryGirl.create(:user, business_id: @business.id)
		@role = Role.create(name: "admin", business_id: @business.id)
		@assignment = FactoryGirl.create(:assignment, role_id: @role.id, user_id: @user.id)
	end
	describe "GET #index" do
		before do
			@issue = FactoryGirl.create(:issue, business_id: @business.id)
		end
		context "and the user is logged in" do
			before do
				sign_in @user
			end
			context "and the user has the 'read' issue right" do
				before do
					@right_read = FactoryGirl.create(:right, resource: "issues", operation: "READ")
					@grant_read = FactoryGirl.create(:grant, role_id: @role.id, right_id: @right_read.id)
					@first = FactoryGirl.create(:issue, state: "publish", created_at: "2014-11-05", business_id: @business.id)
					@second = FactoryGirl.create(:issue, state: "publish", created_at: "2014-11-07", business_id: @business.id)
					@third = FactoryGirl.create(:issue, state: "publish", created_at: "2014-11-10", business_id: @business.id)
					@fourth = FactoryGirl.create(:issue, state: "draft", business_id: @business.id)
					@fifth = FactoryGirl.create(:issue, state: "publish", business_id: @business1.id, created_at: "2014-11-06")
					@sixth = FactoryGirl.create(:issue, state: "publish", business_id: @business1.id, created_at: "2014-11-08")

				end
				it "of published issues in decending order" do
					get :index
					expect(assigns(:issues)).to match_array([@third, @second, @first])
				end
				it "renders the index template" do
					get :index
					expect(response).to render_template :index
				end
				it "returns only the issues that the current user can access" do
					get :index
					expect(assigns(:issues).include?(@fifth)).to eq false
					expect(assigns(:issues).include?(@sixth)).to eq false
				end
			end
			context "and the user does not have 'read' issue right" do
				it "redirects to the home page" do
					get :index
					expect(response).to redirect_to home_path
				end
			end
		end
		context "and the user is not logged in" do
			it "redirects to the login page" do
				get :index
				expect(response).to redirect_to new_user_session_path
			end
		end
	end

	describe "GET #show" do
		before do
			@issue = FactoryGirl.create(:issue, business_id: @business.id)
		end
		context "the user is logged in" do
			before do
				sign_in @user
			end
			context "has the 'read' right" do
				before do
					@right_read = FactoryGirl.create(:right, resource: "issues", operation: "READ")
					@grant_read = FactoryGirl.create(:grant, role_id: @role.id, right_id: @right_read.id)
					get :show, id: @issue
				end
				it "cant find the issue" do
					get :show, id: 9999
					expect(response.response_code).to eq 302
					expect(response).to redirect_to "/404.html"
				end
				it "renders the show template" do
					expect(response).to render_template 'issues/show_workarounds'
				end
				it {should render_with_layout 'show_issue'} 
				it "will have the list instance variable" do
					expect(assigns[:list]).to be_true
				end
			end
			context "does not have the 'read' right" do
				before do
					get :show, id: @issue
				end
				it 'will redirect to home page' do
					expect(response).to redirect_to home_path
				end
				it "will not display the 'show' template" do
					expect(response).to_not render_template :show
				end
			end
		end
		context "the user is not logged in" do
			before do
				get :show, id: @issue.id
			end
			it "will redirect to the login page" do
				expect(response).to redirect_to new_user_session_path
			end
			it "will not render the show template" do
				expect(response).to_not render_template :show
			end
		end
	end

	describe "GET #new" do
		context "and the user is logged in" do
			before do
				sign_in @user
			end
			context "the user has the 'create' right" do
				before do
					@right_read = FactoryGirl.create(:right, resource: "issues", operation: "READ")
					@grant_read = FactoryGirl.create(:grant, role_id: @role.id, right_id: @right_read.id)
					@right_create = FactoryGirl.create(:right, resource: "issues", operation: "CREATE")
					@grant_create = FactoryGirl.create(:grant, role_id: @role.id, right_id: @right_create.id)
					get :new
				end
				it "assigns a new issue to @issue" do
					expect(assigns(:issue)).to be_a_new(Issue)
				end
				it "renders the new template" do
					expect(response).to render_template :new
				end
			end
			context "the user does not have the 'create' right" do
				before do
					sign_in @user
					get :new
				end
				it "will redirect to the home page" do
					expect(response).to redirect_to home_path
				end
				it "will not render the new template" do
					expect(response).to_not render_template :new
				end
			end
		end
		context "and the user is not logged in" do
			before do
				get :new
			end
			it "will not render the new issue page" do
				expect(response).to_not render_template :new
			end
			it "will redirect to login page" do
				expect(response).to redirect_to new_user_session_path
			end
		end
	end
	describe "GET #edit" do
		before do
			@issue = FactoryGirl.create(:issue, business_id: @business.id)
		end
		context "when the user is logged in" do
			context "and the user has the update right" do
				before do
					@right_read = FactoryGirl.create(:right, resource: "issues", operation: "READ")
					@grant_read = FactoryGirl.create(:grant, role_id: @role.id, right_id: @right_read.id)
					@right_update = FactoryGirl.create(:right, resource: "issues", operation: "UPDATE")
					@grant_update = FactoryGirl.create(:grant, role_id: @role.id, right_id: @right_update.id)
					sign_in @user
					get :edit, id: @issue.id
				end
				# it "assigns a issue to @issue" do
				# 	expect(assigns(:issue)).to eq @issue
				# end
				# it "renders the edit template" do
				# 	expect(response).to render_template :edit
				# end

				it "renders the template in the 'edit_page' layout" do
					expect(response).to render_with_layout "edit_page"
				end
			end
			context "and when the user does not have the 'update' right" do
				before do
					sign_in @user
					get :edit, id: @issue.id
				end
				it "will not render the 'edit' template" do
					expect(response).to_not render_template :edit
				end
				it "will redirect to the home page" do
					expect(response).to redirect_to home_path
				end
			end
		end
		context "when the user is not logged in" do
			before do
				get :edit, id: @issue.id
			end
			it "will not render the edit template" do
				expect(response).to_not render_template :edit
			end
			it "will redirect to the login page" do
				expect(response).to redirect_to new_user_session_path
			end
		end
	end
	describe "POST #create" do
		context "when the user is logged in" do
			context "and the user has the 'create' issue right" do
				before do
					@right_read = FactoryGirl.create(:right, resource: "issues", operation: "READ")
					@grant_read = FactoryGirl.create(:grant, role_id: @role.id, right_id: @right_read.id)
					@right_create = FactoryGirl.create(:right, resource: "issues", operation: "CREATE")
					@grant_create = FactoryGirl.create(:grant, role_id: @role.id, right_id: @right_create.id)
					sign_in @user
				end
				context "with valid attributes" do
					before do
						@issue = FactoryGirl.attributes_for(:issue, business_id: @business.id)
					end
					it "saves the new issue to the database" do
						expect {
							post :create, issue: @issue
						}.to change(Issue, :count).by(1)
					end
					it "redirects to the issues#index after save" do
						post :create, issue: FactoryGirl.attributes_for(:issue)
						expect(response).to redirect_to issue_path(assigns[:issue])
					end
					it "assigns the user id to the issue" do
						post :create, issue: FactoryGirl.attributes_for(:issue)
						expect(assigns(:issue).user_id).to eq @user.id
					end
					it "returns the neccessary instance variables" do
						post :create, issue: FactoryGirl.attributes_for(:issue)
						[:issue].each do |instance_variable|
							expect(assigns(instance_variable)).to_not be_nil
						end
					end
					it "will have a flash message" do
						post :create, issue: FactoryGirl.attributes_for(:issue)
						expect(flash[:notice]).to eq "Issue was created successfully"
					end
				end
				context "with invalid attributes" do
					it "does not create the issue" do
						expect {
							post :create, issue: FactoryGirl.attributes_for(:invalid_issue)
						}.to change(Issue, :count).by(0)
					end
					it "renders the 'new' template" do
						post :create, issue: FactoryGirl.attributes_for(:invalid_issue)
						expect(response).to render_template :new
					end
					it "will have a flash message" do
						post :create, issue: FactoryGirl.attributes_for(:invalid_issue)
						expect(flash[:alert]).to eq "Issue is not valid"
					end
				end
			end
			context "and the user does not have the 'create' right" do
				before do
					sign_in @user
				end
				it 'will not create an issue' do
					expect { post :create, issue: FactoryGirl.attributes_for(:issue) }.to change(Issue, :count).by(0)
				end
				it 'will redirect to the issues home page' do
					post :create, issue: FactoryGirl.attributes_for(:issue)
					expect(response).to redirect_to home_path
				end
			end
		end
		context "when the user is not logged in" do
			it "will not create an issue" do
				expect {post :create, issue: FactoryGirl.attributes_for(:issue)}.to change(Issue, :count).by(0)
			end
			it "will redirect to 'home' page" do
				post :create, issue: FactoryGirl.attributes_for(:issue)
				expect(response).to redirect_to new_user_session_path
			end
		end
	end

	describe "PATCH #update" do
		before do
			@issue = FactoryGirl.create(:issue, name: "issue a", business_id: @business.id)
		end
		context "when the user is logged in" do
			context "and the user has the update right" do
				before do
					@right_read = FactoryGirl.create(:right, resource: "issues", operation: "READ")
					@grant_read = FactoryGirl.create(:grant, role_id: @role.id, right_id: @right_read.id)
					@right_update = FactoryGirl.create(:right, resource: "issues", operation: "UPDATE")
					@grant = FactoryGirl.create(:grant, role_id: @role.id, right_id: @right_update.id)
					sign_in @user
				end
				context "with valid attributes" do
					it "locates the requested issue" do
						patch :update, id: @issue, issue: FactoryGirl.attributes_for(:issue)
						expect(assigns(:issue)).to eq(@issue)
					end
					it "will update the issue with new attributes" do
						patch :update, id: @issue, issue: FactoryGirl.attributes_for(:issue, name: "new issue name")
						@issue.reload
						expect(@issue.name).to eq "new issue name"
						expect(@issue.name).to_not eq "issue a"
					end
					it "it will redirect to issue path" do
						patch :update, id: @issue, issue: FactoryGirl.attributes_for(:issue)
						expect(response).to redirect_to issue_path
					end
					it "will have the instance variable" do
						patch :update, id: @issue, issue: FactoryGirl.attributes_for(:issue)
						expect(assigns(:issue)).to_not be_nil
					end
					it "will have a flash message" do
						patch :update, id: @issue, issue: FactoryGirl.attributes_for(:issue)
						expect(flash[:notice]).to eq "Issue has been updated"
					end
					it "changes the review date when supplied" do
						new_date = Date.parse((DateTime.now.utc + 1.weeks).to_s).strftime("%d-%m-%Y")
						patch :update, id: @issue, issue: FactoryGirl.attributes_for(:issue, review_date: new_date)
						expect((assigns(:issue).review_date).strftime("%d-%m-%Y")).to eq new_date
					end
					it "changes the review date to two weeks in advance when not supplied" do
						new_date = Date.parse((DateTime.now.utc + 2.weeks).to_s).strftime("%d-%m-%Y")
						data = FactoryGirl.attributes_for(:issue)
						data.except!(:review_date)
						patch :update, id: @issue, issue: data
						expect((assigns(:issue).review_date).strftime("%d-%m-%Y")).to eq new_date
					end
					it "changes the review date to two weeks in advance when date is less than supplied" do
						submit_date = DateTime.parse((DateTime.now.utc - 2.weeks).to_s).strftime("%d-%m-%Y")
						updated_review_date = DateTime.parse((DateTime.now.utc + 2.weeks).to_s).strftime("%d-%m-%Y")
						patch :update, id: @issue, issue: FactoryGirl.attributes_for(:issue, review_date: submit_date)
						returned_date = (assigns(:issue).review_date).strftime("%d-%m-%Y")
						expect(returned_date).to eq updated_review_date
					end
				end
				context "with invalid attributes" do
					it "will not update the issue" do
						patch :update, id: @issue.id, issue: FactoryGirl.attributes_for(:issue, 
							name: nil)
						@issue.reload
						expect(@issue.name).to eq('issue a')
						expect(@issue.name).to_not be_nil
					end
					it "will render the edit page" do
						patch :update, id: @issue, issue: FactoryGirl.attributes_for(:issue, name: nil)
						expect(response).to render_template :edit
					end
					it "will have a flash message" do
						patch :update, id: @issue, issue: FactoryGirl.attributes_for(:invalid_issue)
						expect(flash[:alert]).to eq "Issue could not be updated"
					end
				end
			end
			context "and the user does not have the update right" do
				before do
					sign_in @user
					patch :update, id: @issue.id, issue: FactoryGirl.attributes_for(:issue, name: "new issue name")
				end
				it "will not update the issue object" do
					@issue.reload
					expect(@issue.name).to eq('issue a')
					expect(@issue.name).to_not eq('new issue name')
				end
				it "will redirect to the home page" do
					expect(response).to redirect_to home_path
				end
			end
		end
		context "when the user is not logged in" do
			before do
				patch :update, id: @issue.id, issue: FactoryGirl.attributes_for(:issue, 
							name: nil)
				@issue.reload
			end
			it "will not update the issue" do
				expect(@issue.name).to eq('issue a')
				expect(@issue.name).to_not be_nil
			end
			it "will redirect to the login page" do
				expect(response).to redirect_to new_user_session_path
			end
		end
	end
	describe "DELETE #destroy" do
		before {@issue = FactoryGirl.create(:issue, business_id: @business.id)}
		context "the user is logged in" do
			context "and the user has delete rights" do
				before do
					@right_read = FactoryGirl.create(:right, resource: "issues", operation: "READ")
					@grant_read = FactoryGirl.create(:grant, role_id: @role.id, right_id: @right_read.id)
					@right = FactoryGirl.create(:right, resource: "issues", operation: "DESTROY")
					@grant = FactoryGirl.create(:grant, role_id: @role.id, right_id: @right.id)
					sign_in @user
				end
				it "can delete the issue" do
					pp session
					expect(@user.can?("destroy", "issues")).to eq(true)
				end
				it "deletes the issue" do
					expect { delete :destroy, id: @issue }.to change(Issue, :count).by(-1)
				end
				it "redirects to the issue index" do
					delete :destroy, id: @issue
					expect(response).to redirect_to issues_path
				end
				it "has the flash message" do
					delete :destroy, id: @issue
					expect(flash[:notice]).to eq "Issue has been destroyed"
				end
			end
			context "and the user does not have the destroy right" do
				it "will redirect to the home page" do
					sign_in @user
					delete :destroy, id: @issue
					expect(response).to redirect_to home_path
				end
			end
		end
		context "if user is not signed in" do
			it "will not delete the issue" do
				expect { delete :destroy, id: @issue }.to change(Issue, :count).by(0)
			end
			it "will redirect to the sign up page" do
				delete :destroy, id: @issue
				expect(response).to redirect_to new_user_session_path
			end
		end
	end


	describe "GET #show_workarounds", first: true do
		before do
			@issue = FactoryGirl.create(:issue, business_id: @business.id)
			@issue_workaround = Review.create(type: 'IssueWorkaround', issue_id: @issue.id, description: "qwerty", review_date: "2015-03-03")
		end
		context "when the user is logged in" do
			before do
				sign_in @user
			end
			context "the user has read access" do
				before do
					@right_read = FactoryGirl.create(:right, resource: "issues", operation: "READ")
					@grant_read = FactoryGirl.create(:grant, role_id: @role.id, right_id: @right_read.id)
					@right_update = FactoryGirl.create(:right, resource: "issues", operation: "UPDATE")
					@grant_update = FactoryGirl.create(:grant, role_id: @role.id, right_id: @right_update.id)
					get :show_workarounds, id: @issue.id
				end
				it "will have the @list instance variable" do
					expect(assigns[:list]).to_not be_nil
				end
				it "will have one issue workaround in the @list instance variable" do
					expect(assigns[:list]).to match_array([@issue_workaround])
				end
				it "will render the 'show workarounds' template" do
					expect(response).to render_template :show_workarounds
				end
				it "will render the correct layout" do
					expect(response).to render_with_layout :show_issue
				end
			end
			context "the user does not have read access" do
				it "redirect to the home page" do
					get :show_workarounds, id: @issue.id
					expect(response).to redirect_to home_path
				end
			end
		end
		context "when the user is NOT logged in" do
			it "redirects to the login page" do
				get :show_workarounds, id: @issue.id
				expect(response).to redirect_to new_user_session_path
			end
		end
	end

end