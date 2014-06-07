module IssueHelper
	def tweet_favorites(favorites)
  
  
	  str = "<p>This tweet has been favorited "
	  str += "<span>#{pluralize(favorites.size, 'time')}</span>,"
	  str += "most recently by #{favorites.to_sentence}</p>"
	  raw(str)
	  end

	  def display_sub_field(fields, text, issue)
	  	str = ""
	  	fields.each do |field|
	  		str += "<tr>"
	  		if field.images.size > 0
		  		field.images.each do |image|
		  			str += "<td>#{ image_tag image.picture.url(:thumb) }</td>"
		  		end
		  	else
		  		str += "<td>No Image</td>"
		  	end
	  		str += "<td>#{ field[text] }</td>"
	  		str += "<td>#{ link_to "Record", new_issue_workaround_record_path(field)}</td>"
	  		str += "</tr>"
	  	end
	  	
	  	raw(str)
	  end

	  def display_images(images)
	  	str = ""
	  	images.each do |image|
	  		str += image_tag image.picture.url(:medium)
	  	end
	  	raw(str)
	  end 
end
