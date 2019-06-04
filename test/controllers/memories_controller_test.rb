require 'test_helper'

class MemoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get memories_index_url
    assert_response :success
  end

end
