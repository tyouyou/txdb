require 'test_helper'

class DisatanceAndTimesControllerTest < ActionController::TestCase
  setup do
    @disatance_and_time = disatance_and_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:disatance_and_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create disatance_and_time" do
    assert_difference('DisatanceAndTime.count') do
      post :create, disatance_and_time: { cost_time: @disatance_and_time.cost_time, distance: @disatance_and_time.distance, end_id: @disatance_and_time.end_id, start_id: @disatance_and_time.start_id }
    end

    assert_redirected_to disatance_and_time_path(assigns(:disatance_and_time))
  end

  test "should show disatance_and_time" do
    get :show, id: @disatance_and_time
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @disatance_and_time
    assert_response :success
  end

  test "should update disatance_and_time" do
    patch :update, id: @disatance_and_time, disatance_and_time: { cost_time: @disatance_and_time.cost_time, distance: @disatance_and_time.distance, end_id: @disatance_and_time.end_id, start_id: @disatance_and_time.start_id }
    assert_redirected_to disatance_and_time_path(assigns(:disatance_and_time))
  end

  test "should destroy disatance_and_time" do
    assert_difference('DisatanceAndTime.count', -1) do
      delete :destroy, id: @disatance_and_time
    end

    assert_redirected_to disatance_and_times_path
  end
end
