module UsersHelper
	def issue_status(s)
		if s == 'publish'
			return 'success'
		end
		if s == 'draft'
			return 'primary'
		end
		if s == 'review'
			return 'warning'
		end
	end
end
