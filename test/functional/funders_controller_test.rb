require 'test_helper'

class FundersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:funders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create funder" do
    assert_difference('Funder.count') do
      post :create, :funder => { }
    end

    assert_redirected_to funder_path(assigns(:funder))
  end

  test "should show funder" do
    get :show, :id => funders(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => funders(:one).to_param
    assert_response :success
  end

  test "should update funder" do
    put :update, :id => funders(:one).to_param, :funder => { }
    assert_redirected_to funder_path(assigns(:funder))
  end

  test "should destroy funder" do
    assert_difference('Funder.count', -1) do
      delete :destroy, :id => funders(:one).to_param
    end

    assert_redirected_to funders_path
  end
end
