require 'test_helper'

class BillingInformationsControllerTest < ActionController::TestCase
  setup do
    @billing_information = billing_informations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:billing_informations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create billing_information" do
    assert_difference('BillingInformation.count') do
      post :create, billing_information: { expiration: @billing_information.expiration, first_name: @billing_information.first_name, last_name: @billing_information.last_name, type: @billing_information.type }
    end

    assert_redirected_to billing_information_path(assigns(:billing_information))
  end

  test "should show billing_information" do
    get :show, id: @billing_information
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @billing_information
    assert_response :success
  end

  test "should update billing_information" do
    patch :update, id: @billing_information, billing_information: { expiration: @billing_information.expiration, first_name: @billing_information.first_name, last_name: @billing_information.last_name, type: @billing_information.type }
    assert_redirected_to billing_information_path(assigns(:billing_information))
  end

  test "should destroy billing_information" do
    assert_difference('BillingInformation.count', -1) do
      delete :destroy, id: @billing_information
    end

    assert_redirected_to billing_informations_path
  end
end
