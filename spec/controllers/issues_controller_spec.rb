require 'spec_helper'

describe IssuesController do
	describe "GET #index" do
		context "returns an array" do
			before do
				@first = FactoryGirl.create(:issue, state: "publish", created_at: "2014-11-05")
				@second = FactoryGirl.create(:issue, state: "publish", created_at: "2014-11-07")
				@third = FactoryGirl.create(:issue, state: "publish", created_at: "2014-11-10")
				@fourth = FactoryGirl.create(:issue, state: "draft")
			end
			it "of published issues in decending order" do
				get :index
				expect(assigns(:issues)).to match_array([@third, @second, @first])
			end
		end
		it "renders the index template" do
			get :index
			expect(response).to render_template :index
		end

	end

	describe "GET #show" do
		before { @issue = FactoryGirl.create(:issue) }
		it "assigns a new issue to @issue" do
			get :show, id: @issue
			expect(assigns(:issue)).to eq @issue
		end
		it "renders the show template" do
			get :show, id: @issue
			expect(assigns(:issue)).to eq @issue
		end
	end

	describe "GET #new" do
		it "assigns a new issue to @issue" do
			get :new
			expect(assigns(:issue)).to be_a_new(Issue)
		end
		it "renders the new template" do
			get :new
			expect(response).to render_template :new
		end
	end
	describe "GET #edit" do
		it "assigns a issue to @issue" do
			issue = FactoryGirl.create(:issue)
			get :edit, id: issue.id
			expect(assigns(:issue)).to eq issue
		end
		it "renders the edit template" do
			issue = FactoryGirl.create(:issue)
			get :edit, id: issue.id
			expect(response).to render_template :edit
		end
	end
	describe "POST #create" do
		context "with valid attributes" do
			before do
				@issue = FactoryGirl.attributes_for(:issue)
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
		end
	end

	describe "PATCH #update" do
		before do
			@issue = FactoryGirl.create(:issue, name: "issue a")
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
		end
	end
	describe "DELETE #destroy" do
		before {@issue = FactoryGirl.create(:issue)}
		it "deletes the issue" do
			expect {delete :destroy, id: @issue}.to change(Issue, :count).by(-1)
		end
		it "redirects to the issue index" do
			delete :destroy, id: @issue
			expect(response).to redirect_to issues_path
		end
	end
end