require 'test_helper'

class LinkedClothingItemsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => LinkedClothingItem.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    LinkedClothingItem.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    LinkedClothingItem.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to linked_clothing_item_url(assigns(:linked_clothing_item))
  end

  def test_edit
    get :edit, :id => LinkedClothingItem.first
    assert_template 'edit'
  end

  def test_update_invalid
    LinkedClothingItem.any_instance.stubs(:valid?).returns(false)
    put :update, :id => LinkedClothingItem.first
    assert_template 'edit'
  end

  def test_update_valid
    LinkedClothingItem.any_instance.stubs(:valid?).returns(true)
    put :update, :id => LinkedClothingItem.first
    assert_redirected_to linked_clothing_item_url(assigns(:linked_clothing_item))
  end

  def test_destroy
    linked_clothing_item = LinkedClothingItem.first
    delete :destroy, :id => linked_clothing_item
    assert_redirected_to linked_clothing_items_url
    assert !LinkedClothingItem.exists?(linked_clothing_item.id)
  end
end
