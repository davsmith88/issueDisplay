class NotificationsController < ApplicationController

	def activity_feed
		# what the user does
		@activities = PublicActivity::Activity.where(owner_id: current_user.id)
		# @activities = PublicActivity::Activity.all
	end

	def notification
		# What other user on the website do
		@activities = PublicActivity::Activity.where.not(owner_id: current_user.id)
		 # @activities = PublicActivity::Activity.all
	end
end
