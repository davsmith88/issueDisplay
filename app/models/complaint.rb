class Complaint < ActiveRecord::Base
	self.per_page = 10

	MACHINE_CODES = {"BHS" => "35", "XITEX" => "40" ,"180" => "180", "190" => "190"}

	PRIORITIES = {"Select One" => "0", "Critical" => "1", "Major" => "2", "Important" => "3", "Low" => "4" }


end
