require "test_helper"

class PurchasesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get purchases_url
    assert_response :success
  end  
  
end
