require 'test_helper'

class ContactPartnersControllerTest < ActionController::TestCase
  setup do
    @contact_partner = contact_partners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contact_partners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact_partner" do
    assert_difference('ContactPartner.count') do
      post :create, contact_partner: { email: @contact_partner.email, firstname: @contact_partner.firstname, institution: @contact_partner.institution, name: @contact_partner.name, tnumber: @contact_partner.tnumber }
    end

    assert_redirected_to contact_partner_path(assigns(:contact_partner))
  end

  test "should show contact_partner" do
    get :show, id: @contact_partner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contact_partner
    assert_response :success
  end

  test "should update contact_partner" do
    put :update, id: @contact_partner, contact_partner: { email: @contact_partner.email, firstname: @contact_partner.firstname, institution: @contact_partner.institution, name: @contact_partner.name, tnumber: @contact_partner.tnumber }
    assert_redirected_to contact_partner_path(assigns(:contact_partner))
  end

  test "should destroy contact_partner" do
    assert_difference('ContactPartner.count', -1) do
      delete :destroy, id: @contact_partner
    end

    assert_redirected_to contact_partners_path
  end
end
