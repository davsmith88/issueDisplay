require 'test_helper'

class Api::IssuesControllerTest < ActionController::TestCase
	# the below line is used to include the devise test helpers
	include Devise::TestHelpers
	test 'should get index' do
		# to use fixtures in tests
		# puts issues(:first_issue).name
		# puts Issue.count
		user = users(:writeUser)
		sign_in user
		get :index, {format: :json}
		assert_response :success
		assert_not_nil assigns(:issues)
		# assert_equal(2, assigns(:issues).count, "issues instance variable should only include the published issues")
		assigns(:issues).each do |issue|
			assert_equal "publish",issue.state,"issue instance variable should only return published issues"
		end
	end

	test 'should create an issue' do
		# to check that json is returned, parse the @response.body and check the data in the variable
		user = users(:writeUser)
		sign_in user
		assert_difference 'Issue.count', 1 do
			post :create, {format: :json, issue: {name: "another issue", description: "random words added"}}
		end
		data = JSON.parse(response.body)
		assert_response :success
		assert_equal "another issue", data['issue']['name']
	end

	test 'should create an issue error' do
		user = users(:writeUser)
		sign_in user
		assert_difference 'Issue.count', 0 do
			post :create, {format: :json, issue: {name: "", description: ""}}
		end
		data = JSON.parse(response.body)
		assert_response 422
		assert data['error'].present?, "An error object must be returned if an error occurs"
	end

	test 'should update an issue' do
		issue = issues(:first_issue)
		user = users(:writeUser)
		sign_in user
		put :update, {format: :json, id: issue.id, issue:{name: "blah"}}
		data = JSON.parse(response.body)
		assert_equal "blah", data['issue']['name']
		assert_not_equal "Drive side dam will not move", data['issue']['name']
		assert_response :success
	end

	test 'should return an error if update fails' do
		issue = issues(:first_issue)
		user = users(:writeUser)
		sign_in user
		put :update, {format: :json, id: issue.id, issue: {name: "", description: ""}}
		data = JSON.parse(response.body)
		assert_not_equal "", issues(:first_issue).name
		assert_equal "Drive side dam will not move", issues(:first_issue).name
		assert_response 422
		assert data['error'].present?, "An error object must be returned if an error occurs"
	end
	test "should not delete error" do
		issue = issues(:first_issue)
		user = users(:writeUser)
		sign_in user
		assert_difference "Issue.count", 0 do
			delete :destroy, {format: :json, id: issue.id}
		end
		assert_response 401
	end
	test "should delete an issue" do
		issue = issues(:first_issue)
		user = users(:adminUser)
		sign_in user
		assert_difference 'Issue.count', -1 do
			delete :destroy, {format: :json, id: issue.id}
		end
		assert_response 204
		assert_equal 0, response.body.length
	end
	# cannot implement until set up permissions fixtures
end