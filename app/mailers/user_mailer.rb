class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'

	def welcome_email(user)
		@user = user
		@url = 'http://example.com/login'
		mail(to: @user.email, subject: 'Welcome to my awesome site')
	end

	def issue_create_email(issue, user)
		@user = user
		@issue = issue
		@url = "http://localhost#{ issue_path(issue) }.html"
		mail(to: @user.email, subject: "A Newly created email")
	end
end
