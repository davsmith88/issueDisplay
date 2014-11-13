require 'spec_helper'

feature "admin - issue management" do
	context "changing states through the admin interface" do
		before do
			@user = FactoryGirl.create(:user)
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