require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "GET /users returns a JSON collection" do
    get users_url, as: :json

    assert_response :success

    body = JSON.parse(response.body)
    users = body.fetch("data")

    assert_equal 2, users.length

    usernames = users.map do |user|
      user.fetch("attributes").fetch("username")
    end

    assert_equal %w[alice bob], usernames.sort
  end

  test "POST /users creates a user" do
    assert_difference("User.count", 1) do
      post users_url,
           params: { user: { username: "charlie" } },
           as: :json
    end

    assert_response :success

    body = JSON.parse(response.body)

    assert_equal(
      "charlie",
      body.dig("data", "attributes", "username")
    )
  end
end
