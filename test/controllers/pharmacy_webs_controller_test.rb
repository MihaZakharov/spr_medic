require 'test_helper'

class PharmacyWebsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pharmacy_web = pharmacy_webs(:one)
  end

  test "should get index" do
    get pharmacy_webs_url
    assert_response :success
  end

  test "should get new" do
    get new_pharmacy_web_url
    assert_response :success
  end

  test "should create pharmacy_web" do
    assert_difference('PharmacyWeb.count') do
      post pharmacy_webs_url, params: { pharmacy_web: { addres: @pharmacy_web.addres, director: @pharmacy_web.director, name: @pharmacy_web.name, phone: @pharmacy_web.phone } }
    end

    assert_redirected_to pharmacy_web_url(PharmacyWeb.last)
  end

  test "should show pharmacy_web" do
    get pharmacy_web_url(@pharmacy_web)
    assert_response :success
  end

  test "should get edit" do
    get edit_pharmacy_web_url(@pharmacy_web)
    assert_response :success
  end

  test "should update pharmacy_web" do
    patch pharmacy_web_url(@pharmacy_web), params: { pharmacy_web: { addres: @pharmacy_web.addres, director: @pharmacy_web.director, name: @pharmacy_web.name, phone: @pharmacy_web.phone } }
    assert_redirected_to pharmacy_web_url(@pharmacy_web)
  end

  test "should destroy pharmacy_web" do
    assert_difference('PharmacyWeb.count', -1) do
      delete pharmacy_web_url(@pharmacy_web)
    end

    assert_redirected_to pharmacy_webs_url
  end
end
