require 'test_helper'

class QwersControllerTest < ActionController::TestCase
  setup do
    @qwer = qwers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qwers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qwer" do
    assert_difference('Qwer.count') do
      post :create, qwer: { name: @qwer.name }
    end

    assert_redirected_to qwer_path(assigns(:qwer))
  end

  test "should show qwer" do
    get :show, id: @qwer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @qwer
    assert_response :success
  end

  test "should update qwer" do
    patch :update, id: @qwer, qwer: { name: @qwer.name }
    assert_redirected_to qwer_path(assigns(:qwer))
  end

  test "should destroy qwer" do
    assert_difference('Qwer.count', -1) do
      delete :destroy, id: @qwer
    end

    assert_redirected_to qwers_path
  end
end
