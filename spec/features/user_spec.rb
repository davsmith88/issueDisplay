require 'spec_helper'

feature 'login' do
	context "with a valid user is" do
		before do
			@user = FactoryGirl.create(:user)
		end
		scenario 'able to log in via the login page' do
			login(email: @user.email, password: @user.password)
			expect(page).to have_content("Signed in successfully")
		end
		scenario "a failed login attempt" do
			login(email: @user.email, password: "a different password")
			expect(page).to have_content("Invalid email or password")
		end
		scenario "can view the users profile" do

		end
	end
end

feature "a new user signs up" do
	scenario "with the sign up form" do

	end
end