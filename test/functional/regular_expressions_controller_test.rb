require 'test_helper'

class RegularExpressionsControllerTest < ActionController::TestCase
  setup do
    @regular_expression = regular_expressions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:regular_expressions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create regular_expression" do
    assert_difference('RegularExpression.count') do
      post :create, regular_expression: { name: @regular_expression.name }
    end

    assert_redirected_to regular_expression_path(assigns(:regular_expression))
  end

  test "should show regular_expression" do
    get :show, id: @regular_expression
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @regular_expression
    assert_response :success
  end

  test "should update regular_expression" do
    put :update, id: @regular_expression, regular_expression: { name: @regular_expression.name }
    assert_redirected_to regular_expression_path(assigns(:regular_expression))
  end

  test "should destroy regular_expression" do
    assert_difference('RegularExpression.count', -1) do
      delete :destroy, id: @regular_expression
    end

    assert_redirected_to regular_expressions_path
  end
end
