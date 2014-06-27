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
	  			str += "<td>"
	  			
	  			str += create_carousel(field.images, field.id)

		  		
		  		str += "</td>"
		  	else
		  		str += "<td>No Image</td>"
		  	end
		  	
	  		str += "<td>#{ field[text] }</td>"
	  		str += "<td>#{ link_to "Record", new_issue_workaround_record_path(field)}</td>"
	  		str += "</tr>"
	  	end
	  	
	  	raw(str)
	  end

	  def create_carousel(images, id)


	  	str = ""
	   	str += "<div id=\"carousel-example-#{id}\" class=\"carousel slide\" data-ride=\"carousel\">"
			 
			   str += "<ol class=\"carousel-indicators\">"
			   	images.each_with_index do |image, index|
			   		if index == 0
			   			str += "<li data-target=\'#carousel-example-generic\' data-slide-to='0' class='active'></li>"
			   		else
			   			str += "<li data-target='#carousel-example-generic' data-slide-to='#{ index }' ></li>"
			   		end
			   	end
			   str += "</ol>"

			#   <!-- Wrapper for slides -->
			   str += "<div class=\"carousel-inner\">"

			  		

			   	images.each_with_index do |image, index|
			   		if index == 0
			   			str += "<div class=\"item active\">"
			 	      str += "<img src=\" #{ image.picture.url(:medium) } \" alt=\"...\">"
				      str += "<div class=\"carousel-caption\">"
				        
			 	      str += "</div>"
			 	    str += "</div>"
			   		else
			 	    str += "<div class=\"item\">"
			 	      str += "<img src=\"#{ image.picture.url(:medium)}\" alt=\"...\">"
				      str += "<div class=\"carousel-caption\">"
				        
				      str += "</div>"
				    str += "</div>"
			 	    end 
			     end
			    
			   str += "</div>"

			   str += "<a class=\"left carousel-control\" href=\"#carousel-example-#{id}\" data-slide=\"prev\">
			     <span class=\"glyphicon glyphicon-chevron-left\"></span>
			   </a>
			   <a class=\"right carousel-control\" href=\"#carousel-example-#{id}\" data-slide=\"next\">
			     <span class=\"glyphicon glyphicon-chevron-right\"></span>
			  </a>
			 </div>"
	  end

	  def display_images(images)
	  	str = ""
	  	images.each do |image|
	  		str += image_tag image.picture.url(:medium)
	  	end
	  	raw(str)
	  end 
end
