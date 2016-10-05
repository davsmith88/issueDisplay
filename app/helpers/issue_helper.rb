module IssueHelper

	def tweet_favorites(favorites)
  
  
	  str = "<p>This tweet has been favorited "
	  str += "<span>#{pluralize(favorites.size, 'time')}</span>,"
	  str += "most recently by #{favorites.to_sentence}</p>"
	  raw(str)
	  end

	  def department_types(d)
	  	q = [] 
	  	d.each do |dep| q.push([dep.name, dep.id]) end 
	  	q
	  end 

	  def impacts(list, issue_impact)
	  	q = ""
	  	list.each do |l|
	  		puts l.id
	  		if l.id == issue_impact.impact_id
	  			q += "<option value='#{ l.id }' selected>#{ l.name }</option>"
		  	else
	  			q += "<option value='#{ l.id }' >#{ l.name }</option>"
	  		end
	  	end
	  	q.html_safe
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

	# def tab_name(workaround)
	# 	case workaround
	# 		when "steps"
	# 			link_to("Workarounds",show_workarounds_issue_path(@issue))
	# 		when 'workarounds'
				
	# 		when 'solutions'	
	# 			link_to("Solutions", show_solutions_issue_path(@issue))
	# 	end
	# end

	def select_which_add_link(name)
		case name
			when "solutions"
				link_to("Add One Today", new_issue_solution_path(@issue), class: "btn btn-primary btn-sm")
			when "workarounds"
				link_to("Add one Today", new_issue_issue_workaround_path(@issue), class: "btn btn-primary btn-sm" )
		end
	end
end
