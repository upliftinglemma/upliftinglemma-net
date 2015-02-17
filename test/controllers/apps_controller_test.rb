require 'test_helper'

class AppsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get not_found" do
    get :not_found
    assert_response :success
  end

end
