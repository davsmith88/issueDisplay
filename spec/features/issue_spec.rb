require 'rails_helper'

feature "issue" do
	context "with a login user with admin rights" do
		let(:business) { setup_basic_business_defaults }
		let(:user) { FactoryGirl.create(:user, permType: 'admin', business_id: business.id) }
		before do
			
		end
		scenario "creates a new issue" do
			login( email: user.email, password: user.password )
			visit issues_path
			click_link "Add New Issue"
			
			expect {
				fill_in "issue_name", with: "Machine will not start"
				fill_in "issue_description", with: "a basic description"
				select "wet end bhs", from: "issue_department_area_id"
				select "Downtime", from: "issue_impact_id"
				fill_in "issue_review_date", with: DateTime.parse((DateTime.now + 3.weeks).to_s).strftime("%d/%m/%Y")
				click_link_or_button "Save"
			}.to change(Issue, :count).by(1)
			expect(page).to have_content("Issue was created successfully")
		end
	end
end