module GrantsHelper

	def create_diabled_checkboxes(a)
		n = 4 - a.length
		html_string = ""
		(1..n).each do |q|
			temp = content_tag "td" do
				tag :input, {type: "checkbox", disabled: true}
			end
			puts temp
			html_string << temp.html_safe
		end
		return html_string
	end




end
