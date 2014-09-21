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
		"index" => "READ"
		#, "draft_to_review" => "REVIEW"
		#, "review_to_publish" => "PUBLISH"
	}
end
