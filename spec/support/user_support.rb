module UserHelper
	def login(a)
		visit new_user_session_path
		fill_in "user_email", with: a[:email]
		fill_in "user_password", with: a[:password]
		click_link_or_button "Sign in"
	end

	def logout
	end

	def create_user_with_all_permissions(user)
		role = Role.create(name: "admin")
		assignment = FactoryGirl.create(:assignment, role_id: role.id, user_id: user.id)

		admin_resource = %w(admin issue_management)
		resources = %w(issue)
		operations = %w(READ UPDATE CREATE DESTROY)

		resources.each do |resource|
			operations.each do |operation|
				right = FactoryGirl.create(:right, resource: resource.pluralize(2), operation: operation)
				FactoryGirl.create(:grant, role_id: role.id, right_id: right.id)
			end
		end

		admin_resource.each do |ar|
			right = FactoryGirl.create(:right, resource: ar, operation: "READ")
			FactoryGirl.create(:grant, role_id: role.id, right_id: right.id)
		end

		return nil
	end

	def setup_basic_business_defaults
		department = FactoryGirl.create(:department, name: "bhs")
		area = FactoryGirl.create(:area, name: "starch kitchen")
		department_area = FactoryGirl.create(:department_area, department: department, area: area)

		department1 = FactoryGirl.create(:department, name: "bhs")
		area1 = FactoryGirl.create(:area, name: "wet end")
		department_area1 = FactoryGirl.create(:department_area, department: department1, area: area1)

		impact = FactoryGirl.create(:impact, name: "Quality")
		impact = FactoryGirl.create(:impact, name: "Run speed")
		impact = FactoryGirl.create(:impact, name: "Downtime")
	end
end