require "test_helper"

class Public::AdderssesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_addersses_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_addersses_edit_url
    assert_response :success
  end
end
