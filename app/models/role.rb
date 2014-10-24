class Role < ActiveRecord::Base
	has_many :grants, dependent: :destroy
	has_many :assignments, dependent: :destroy
	has_many :users, :through => :assignments
	has_many :rights, :through => :grants

	validates :name, uniqueness: true

	scope :for, lambda{|action, resource|
		if action == "new" || action == "create" || action == "edit" || action == "update" || action == "destroy" || action == "index" || action == "show"
			where("rights.operation = ? AND rights.resource = ?",
				Right::OPERATION_MAPPINGS[action], resource
				)
		else
			where("rights.operation = ? AND rights.resource = ?",
				Right::OPERATION_MAPPINGS[resource][action], resource
				)
		end
		}
end
