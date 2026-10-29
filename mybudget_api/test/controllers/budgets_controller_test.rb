require 'test_helper'

class BudgetsControllerTest < ActionDispatch::IntegrationTest
  test "GET /budgets returns a JSON collection" do
    get budgets_url, as: :json

    assert_response :success

    body = JSON.parse(response.body)
    budgets = body.fetch("data")

    assert_equal 2, budgets.length

    budgets.each do |budget|
      assert budget.fetch("attributes").key?("amount")
    end
  end
end
