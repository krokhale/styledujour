require 'test_helper'

class HcitControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get submit_link" do
    get :submit_link
    assert_response :success
  end

end
