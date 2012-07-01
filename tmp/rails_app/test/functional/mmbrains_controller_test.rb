require 'test_helper'

class MmbrainsControllerTest < ActionController::TestCase
  setup do
    @mmbrain = mmbrains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mmbrains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mmbrain" do
    assert_difference('Mmbrain.count') do
      post :create, mmbrain: { name: @mmbrain.name }
    end

    assert_redirected_to mmbrain_path(assigns(:mmbrain))
  end

  test "should show mmbrain" do
    get :show, id: @mmbrain
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mmbrain
    assert_response :success
  end

  test "should update mmbrain" do
    put :update, id: @mmbrain, mmbrain: { name: @mmbrain.name }
    assert_redirected_to mmbrain_path(assigns(:mmbrain))
  end

  test "should destroy mmbrain" do
    assert_difference('Mmbrain.count', -1) do
      delete :destroy, id: @mmbrain
    end

    assert_redirected_to mmbrains_path
  end
end
