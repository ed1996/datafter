require 'test_helper'

class ChargeanimalsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get chargeanimals_new_url
    assert_response :success
  end

  test "should get create" do
    get chargeanimals_create_url
    assert_response :success
  end

end
