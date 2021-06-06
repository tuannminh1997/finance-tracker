require "test_helper"

class CoinsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get coins_search_url
    assert_response :success
  end
end
