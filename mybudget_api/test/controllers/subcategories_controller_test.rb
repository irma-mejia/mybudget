require 'test_helper'

class SubcategoriesControllerTest < ActionDispatch::IntegrationTest
  test "GET /subcategories returns a JSON collection" do
    get subcategories_url, as: :json

    assert_response :success

    body = JSON.parse(response.body)
    subcategories = body.fetch("data")

    assert_equal 2, subcategories.length

    names = subcategories.map do |subcategory|
      subcategory.fetch("attributes").fetch("name")
    end

    assert_equal ["Housing", "Transportation"], names.sort
  end
end
