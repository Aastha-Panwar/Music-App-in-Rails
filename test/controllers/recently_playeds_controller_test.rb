require "test_helper"

class RecentlyPlayedsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recently_playeds_index_url
    assert_response :success
  end
end
