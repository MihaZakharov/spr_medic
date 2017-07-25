require 'test_helper'

class PercentagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @percentage = percentages(:one)
  end

  test "should get index" do
    get percentages_url
    assert_response :success
  end

  test "should get new" do
    get new_percentage_url
    assert_response :success
  end

  test "should create percentage" do
    assert_difference('Percentage.count') do
      post percentages_url, params: { percentage: { group_id: @percentage.group_id, percent_fact: @percentage.percent_fact, percent_inv: @percentage.percent_inv, val_fact_1: @percentage.val_fact_1, val_fact_2: @percentage.val_fact_2, val_inv_1: @percentage.val_inv_1, val_inv_2: @percentage.val_inv_2 } }
    end

    assert_redirected_to percentage_url(Percentage.last)
  end

  test "should show percentage" do
    get percentage_url(@percentage)
    assert_response :success
  end

  test "should get edit" do
    get edit_percentage_url(@percentage)
    assert_response :success
  end

  test "should update percentage" do
    patch percentage_url(@percentage), params: { percentage: { group_id: @percentage.group_id, percent_fact: @percentage.percent_fact, percent_inv: @percentage.percent_inv, val_fact_1: @percentage.val_fact_1, val_fact_2: @percentage.val_fact_2, val_inv_1: @percentage.val_inv_1, val_inv_2: @percentage.val_inv_2 } }
    assert_redirected_to percentage_url(@percentage)
  end

  test "should destroy percentage" do
    assert_difference('Percentage.count', -1) do
      delete percentage_url(@percentage)
    end

    assert_redirected_to percentages_url
  end
end
