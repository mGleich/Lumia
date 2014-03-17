require 'test_helper'

class RegularsControllerTest < ActionController::TestCase
  setup do
    @regular = regulars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:regulars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create regular" do
    assert_difference('Regular.count') do
      post :create, regular: { expression: @regular.expression, name: @regular.name }
    end

    assert_redirected_to regular_path(assigns(:regular))
  end

  test "should show regular" do
    get :show, id: @regular
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @regular
    assert_response :success
  end

  test "should update regular" do
    put :update, id: @regular, regular: { expression: @regular.expression, name: @regular.name }
    assert_redirected_to regular_path(assigns(:regular))
  end

  test "should destroy regular" do
    assert_difference('Regular.count', -1) do
      delete :destroy, id: @regular
    end

    assert_redirected_to regulars_path
  end
end
