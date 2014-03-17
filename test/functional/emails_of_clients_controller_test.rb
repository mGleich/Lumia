require 'test_helper'

class EmailsOfClientsControllerTest < ActionController::TestCase
  setup do
    @emails_of_client = emails_of_clients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emails_of_clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create emails_of_client" do
    assert_difference('EmailsOfClient.count') do
      post :create, emails_of_client: { client_id: @emails_of_client.client_id, email: @emails_of_client.email }
    end

    assert_redirected_to emails_of_client_path(assigns(:emails_of_client))
  end

  test "should show emails_of_client" do
    get :show, id: @emails_of_client
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @emails_of_client
    assert_response :success
  end

  test "should update emails_of_client" do
    put :update, id: @emails_of_client, emails_of_client: { client_id: @emails_of_client.client_id, email: @emails_of_client.email }
    assert_redirected_to emails_of_client_path(assigns(:emails_of_client))
  end

  test "should destroy emails_of_client" do
    assert_difference('EmailsOfClient.count', -1) do
      delete :destroy, id: @emails_of_client
    end

    assert_redirected_to emails_of_clients_path
  end
end
