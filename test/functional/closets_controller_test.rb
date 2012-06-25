require 'test_helper'

class ClosetsControllerTest < ActionController::TestCase
  setup do
    @closet = closets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:closets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create closet" do
    assert_difference('Closet.count') do
      post :create, closet: @closet.attributes
    end

    assert_redirected_to closet_path(assigns(:closet))
  end

  test "should show closet" do
    get :show, id: @closet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @closet
    assert_response :success
  end

  test "should update closet" do
    put :update, id: @closet, closet: @closet.attributes
    assert_redirected_to closet_path(assigns(:closet))
  end

  test "should destroy closet" do
    assert_difference('Closet.count', -1) do
      delete :destroy, id: @closet
    end

    assert_redirected_to closets_path
  end
end
