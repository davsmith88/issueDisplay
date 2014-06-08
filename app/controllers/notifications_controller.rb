class NotificationsController < ApplicationController

	def activity_feed
		# what the user does
		 @activities = PublicActivity::Activity.all
	end

	def notifications
		# What other user on the website do
		 @activities = PublicActivity::Activity.all
	end
end
