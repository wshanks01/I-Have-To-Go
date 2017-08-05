require 'test_helper'

class BathroomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bathroom = bathrooms(:one)
  end

  test "should get index" do
    get bathrooms_url, as: :json
    assert_response :success
  end

  test "should create bathroom" do
    assert_difference('Bathroom.count') do
      post bathrooms_url, params: { bathroom: { address: @bathroom.address, childfriendly: @bathroom.childfriendly, description: @bathroom.description, lat: @bathroom.lat, long: @bathroom.long, name: @bathroom.name, wheelchair: @bathroom.wheelchair } }, as: :json
    end

    assert_response 201
  end

  test "should show bathroom" do
    get bathroom_url(@bathroom), as: :json
    assert_response :success
  end

  test "should update bathroom" do
    patch bathroom_url(@bathroom), params: { bathroom: { address: @bathroom.address, childfriendly: @bathroom.childfriendly, description: @bathroom.description, lat: @bathroom.lat, long: @bathroom.long, name: @bathroom.name, wheelchair: @bathroom.wheelchair } }, as: :json
    assert_response 200
  end

  test "should destroy bathroom" do
    assert_difference('Bathroom.count', -1) do
      delete bathroom_url(@bathroom), as: :json
    end

    assert_response 204
  end
end
