module UserSupport
	def login(a)
		visit new_user_session_path
		fill_in "user_email", with: a[:email]
		fill_in "user_password", with: a[:password]
		click_link_or_button "Sign in"
	end

	def logout
	end

	def setup_basic_business_defaults

		business = FactoryGirl.create(:business)

		department = FactoryGirl.create(:department, name: "bhs", business_id: business)
		area = FactoryGirl.create(:area, name: "starch kitchen", business_id: business)
		department_area = FactoryGirl.create(:department_area, department: department, area: area, business_id: business)

		department1 = FactoryGirl.create(:department, name: "bhs", business_id: business)
		area1 = FactoryGirl.create(:area, name: "wet end", business_id: business)
		department_area1 = FactoryGirl.create(:department_area, department: department1, area: area1, business_id: business)

		impact = FactoryGirl.create(:impact, name: "Quality")
		impact = FactoryGirl.create(:impact, name: "Run speed")
		impact = FactoryGirl.create(:impact, name: "Downtime")
		return business
	end
end