module ApplicationHelper
	def format_date date
		ActiveSupport::Inflector.ordinalize(date.strftime("%d").to_i) + date.strftime(" %B %Y")
	end
end
