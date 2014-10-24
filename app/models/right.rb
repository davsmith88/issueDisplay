class Right < ActiveRecord::Base
	has_many :grants, dependent: :destroy
	has_many :roles, :through => :grants

	validates_uniqueness_of :resource, scope: [:resource, :operation]

	OPERATION_MAPPINGS = {
		"new" => "CREATE",
		"create" => "CREATE",
		"edit" => "UPDATE",
		"update" => "UPDATE",
		"destroy" => "DESTROY",
		"show" => "READ",
		"index" => "READ",
		# controller methods that are not restful (ie fit into the above actions)
		# must be placed in a hash with the method name with the permission to map to
		"admin" => {
			"permissions" => "READ",
			"impacts" => "READ",
			"depareas" => "READ",
			"users" => "READ"
		}
	}
end
