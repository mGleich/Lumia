require 'test_helper'

class TelenumbersOfClientsControllerTest < ActionController::TestCase
  setup do
    @telenumbers_of_client = telenumbers_of_clients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:telenumbers_of_clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create telenumbers_of_client" do
    assert_difference('TelenumbersOfClient.count') do
      post :create, telenumbers_of_client: { number: @telenumbers_of_client.number }
    end

    assert_redirected_to telenumbers_of_client_path(assigns(:telenumbers_of_client))
  end

  test "should show telenumbers_of_client" do
    get :show, id: @telenumbers_of_client
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @telenumbers_of_client
    assert_response :success
  end

  test "should update telenumbers_of_client" do
    put :update, id: @telenumbers_of_client, telenumbers_of_client: { number: @telenumbers_of_client.number }
    assert_redirected_to telenumbers_of_client_path(assigns(:telenumbers_of_client))
  end

  test "should destroy telenumbers_of_client" do
    assert_difference('TelenumbersOfClient.count', -1) do
      delete :destroy, id: @telenumbers_of_client
    end

    assert_redirected_to telenumbers_of_clients_path
  end
end
