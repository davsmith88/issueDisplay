module ApplicationHelper
	def format_date date
		ActiveSupport::Inflector.ordinalize(date.strftime("%d").to_i) + date.strftime(" %B %Y")
	end

	def format_date_time date
		ActiveSupport::Inflector.ordinalize(date.strftime("%d").to_i) + date.strftime(" %B %Y ") + "at" + date.strftime(" %H:%M:%S")
	end

	def create_options(array)
		html = ""
		array.each do |item|
			temp = content_tag(:option, item.name, value: item.id)
			html << temp.html_safe
		end
		html
	end
end
