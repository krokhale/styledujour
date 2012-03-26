require 'test_helper'

class ClothingItemsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => ClothingItem.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    ClothingItem.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    ClothingItem.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to clothing_item_url(assigns(:clothing_item))
  end

  def test_edit
    get :edit, :id => ClothingItem.first
    assert_template 'edit'
  end

  def test_update_invalid
    ClothingItem.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ClothingItem.first
    assert_template 'edit'
  end

  def test_update_valid
    ClothingItem.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ClothingItem.first
    assert_redirected_to clothing_item_url(assigns(:clothing_item))
  end

  def test_destroy
    clothing_item = ClothingItem.first
    delete :destroy, :id => clothing_item
    assert_redirected_to clothing_items_url
    assert !ClothingItem.exists?(clothing_item.id)
  end
end
