require "test_helper"

class TextsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get texts_edit_url
    assert_response :success
  end
end
