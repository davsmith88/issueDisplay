require 'spec_helper'

feature "issue" do
	context "with a login user with admin rights" do
		before do
			@user = FactoryGirl.create(:user)
		end
		scenario "creates a new issue" do
			create_user_with_all_permissions(@user)
			setup_basic_business_defaults
			login(email: @user.email, password: @user.password)
			visit issues_path
			click_link "Create New Issue"

			expect{
				fill_in "issue_name", with: "Machine will not start"
				fill_in "issue_description", with: "a basic description explaining what the machine does"
				select "wet end bhs" , from: "issue_department_area_id"
				select "Downtime", from: "issue_impact_id"
				fill_in "issue_review_date", with: DateTime.parse((DateTime.now + 3.weeks).to_s).strftime("%d/%m/%Y")
				click_link_or_button "Save"
			}.to change(Issue, :count).by(1)
			expect(page).to have_content("Issue was created successfully")
		end
		context "changing states through the admin interface" do
			before do
				create_user_with_all_permissions(@user)
				setup_basic_business_defaults
				login(email: @user.email, password: @user.password)
				@issue = FactoryGirl.create(:issue, state: "draft")
			end
			scenario "switching from draft to review" do
				visit "/admin/issue_management/#{@issue.id}"
				click_link "Review"
				expect(page).to have_content "Issue state has been changed from draft to review"
			end
			scenario "switching from review to publish" do
				@issue.draft_to_review
				visit "/admin/issue_management/#{@issue.id}"
				click_link "Publish"
				expect(page).to have_content "Issue state has been changed from review to publish"
			end
			scenario "switching from publish to review" do
				@issue.state = 'publish'
				@issue.save
				visit "/admin/issue_management/#{@issue.id}"
				click_link "Review"
				expect(page).to have_content "Issue state has been changed from publish to review"
			end
			scenario "switching from publish to draft" do
				@issue.state = 'publish'
				@issue.save
				visit "/admin/issue_management/#{@issue.id}"
				click_link "Draft"
				expect(page).to have_content "Issue state has been changed from publish to draft"
			end
			scenario "switching from review to draft" do
				@issue.state = 'review'
				@issue.save
				visit "/admin/issue_management/#{@issue.id}"
				click_link "Draft"
				expect(page).to have_content "Issue state has been changed from review to draft"
			end
		end
	end
end