require 'test_helper'

class PartOfRulesControllerTest < ActionController::TestCase
  setup do
    @part_of_rule = part_of_rules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:part_of_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create part_of_rule" do
    assert_difference('PartOfRule.count') do
      post :create, part_of_rule: { boperator: @part_of_rule.boperator, test_value: @part_of_rule.test_value }
    end

    assert_redirected_to part_of_rule_path(assigns(:part_of_rule))
  end

  test "should show part_of_rule" do
    get :show, id: @part_of_rule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @part_of_rule
    assert_response :success
  end

  test "should update part_of_rule" do
    put :update, id: @part_of_rule, part_of_rule: { boperator: @part_of_rule.boperator, test_value: @part_of_rule.test_value }
    assert_redirected_to part_of_rule_path(assigns(:part_of_rule))
  end

  test "should destroy part_of_rule" do
    assert_difference('PartOfRule.count', -1) do
      delete :destroy, id: @part_of_rule
    end

    assert_redirected_to part_of_rules_path
  end
end
