module PublicActivityHelper

	def get_action(key)
		index = key.index(".") + 1
		length = key.size
		key[index..length].capitalize
	end

	def display_text_issue(activity, current_user, trackable_text, untrackable)
		str = "<div class='media'><a class='pull-left' href='#''>
    			<img class='media-object' src='...' alt='...''>
  			</a><div class='media-body'><h4 class='media-heading'>#{ get_action activity.key} #{activity.trackable.class.name}</h4><p>"
		# "testing to see what works blah blah"
		if activity.trackable
			if activity.owner_id == current_user.id
				str += "You "
			else
				str += activity.owner.name + " "
			end
			str += trackable_text
			str += link_to activity.trackable.name, activity.trackable
		else
			str += untrackable
		end
		str += "</p></div></div>"
	end

	



	def display_text_solutions(activity, current_user, trackable_text, untrackable)
		str = "<p>"
		# "testing to see what works blah blah"
		if activity.trackable
			if activity.owner_id == current_user.id
				str += "You "
			else
				str += activity.owner.name + " "
			end
			str += trackable_text
			str += link_to activity.trackable.issue.name, activity.trackable.issue
		else
			str += untrackable
		end
		str += "</p>"
	end

end

