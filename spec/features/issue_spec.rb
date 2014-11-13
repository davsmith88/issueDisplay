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

		scenario "edits a published issue" do
			create_user_with_all_permissions(@user)
			setup_basic_business_defaults
			login(email: @user.email, password: @user.password)
			issue = FactoryGirl.create(:issue, state: 'publish')
			visit edit_issue_path(issue)

			fill_in "issue_name", with: "changed issue name"
			click_link_or_button "Save"

			expect(page).to have_content("Issue has been updated")

		end

		scenario "destroys a published issue", js: true do
			create_user_with_all_permissions(@user)
			setup_basic_business_defaults
			login(email: @user.email, password: @user.password)
			issue = FactoryGirl.create(:issue, state: 'publish')

			visit issues_path

			expect{
				click_link "Destroy"
				accept_alert("Are you sure you want to delete")
				sleep(inspection_time=10)
			}.to change(Issue, :count).by(-1)

			expect(page).to have_content "Issue has been destroyed"
			save_and_open_page
		end

		scenario "shows a published issue" do

		end

	end
end