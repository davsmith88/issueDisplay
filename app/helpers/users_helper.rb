module UsersHelper
	def is_active(param, filter)
		if param == filter
			"active"
		end
	end
end
