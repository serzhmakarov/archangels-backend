require "test_helper"

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create_checkout_url" do
    get payments_create_checkout_url_url
    assert_response :success
  end
end
