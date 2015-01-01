require 'test_helper'

class ShipPlacementsControllerTest < ActionController::TestCase
  setup do
    @ship_placement = ship_placements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ship_placements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ship_placement" do
    assert_difference('ShipPlacement.count') do
      post :create, ship_placement: { game_id: @ship_placement.game_id, orientation: @ship_placement.orientation, ship_id: @ship_placement.ship_id, top_left_value: @ship_placement.top_left_value }
    end

    assert_redirected_to ship_placement_path(assigns(:ship_placement))
  end

  test "should show ship_placement" do
    get :show, id: @ship_placement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ship_placement
    assert_response :success
  end

  test "should update ship_placement" do
    patch :update, id: @ship_placement, ship_placement: { game_id: @ship_placement.game_id, orientation: @ship_placement.orientation, ship_id: @ship_placement.ship_id, top_left_value: @ship_placement.top_left_value }
    assert_redirected_to ship_placement_path(assigns(:ship_placement))
  end

  test "should destroy ship_placement" do
    assert_difference('ShipPlacement.count', -1) do
      delete :destroy, id: @ship_placement
    end

    assert_redirected_to ship_placements_path
  end
end
