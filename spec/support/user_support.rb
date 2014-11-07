module UserHelper
	def login(a)
		visit new_user_session_path
		fill_in "user_email", with: a[:email]
		fill_in "user_password", with: a[:password]
		click_link_or_button "Sign in"
	end

	def logout
end