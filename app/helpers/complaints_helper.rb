module ComplaintsHelper
	def is_internal?(c)
		if c
			"<span class='label label-success'>Internal</span>".html_safe
		end
	end

	def has_complaints?(a)
		if !a.nil? && a.length > 0
			"<span class='label label-danger'>C</span>".html_safe
		end
	end

	def is_new?(a)
		prev_date = DateTime.now - 2.weeks
		if a > prev_date
			"<span class='label label-info'>New</span>".html_safe
		end
	end

	def opt_machines(selected)
		a = "<option disabled selected>Please select one</option>".html_safe
		# a + options_for_select(Complaint::MACHINE_CODES, selected: selected) 
		a + options_for_select(["corrugator", "flexo", "diecut"], selected: selected) 
	end

	def priorities(selected)
		a = "<option disabled selected>Please select one</option>".html_safe
		a + options_for_select(Complaint::PRIORITIES, selected: selected)
	end

	def internal_options(selected)
		a = "<option disabled selected>Please select one</option>".html_safe
		a + options_for_select([['True', true], ['False', false]], selected: selected )
	end
end
