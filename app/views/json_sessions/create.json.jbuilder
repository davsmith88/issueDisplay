json.extract! @user, :id, :email, :created_at, :updated_at
json.set! :permissions do
	@permissions.each do |controller, actions|
		json.set! controller do
			actions.each do |act, val|
				json.set! act, val
			end
		end
	end
end
