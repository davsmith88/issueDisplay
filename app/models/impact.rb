class Impact < ActiveRecord::Base
	belongs_to :issue

	self.per_page = 5
end
