module PublicActivityHelper
	def display_text_issue(activity, current_user, trackable_text, untrackable)
		str = "<p>"
		# "testing to see what works blah blah"
		if activity.trackable
			if activity.owner_id == current_user.id
				str += "You "
			else
				str += activity.owner.to_s
			end
			str += trackable_text
			str += link_to activity.trackable.name, activity.trackable
		else
			str += untrackable
		end
		str += "</p>"
	end

	def display_text_solutions(activity, current_user, trackable_text, untrackable)
		str = "<p>"
		# "testing to see what works blah blah"
		if activity.trackable
			if activity.owner_id == current_user.id
				str += "You "
			else
				str += activity.owner.to_s
			end
			str += trackable_text
			str += link_to activity.trackable.issue.name, activity.trackable.issue
		else
			str += untrackable
		end
		str += "</p>"
	end

end

