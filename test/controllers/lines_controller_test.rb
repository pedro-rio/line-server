require "test_helper"

class LinesControllerTest < ActionDispatch::IntegrationTest
  test "Index that exists in file" do
    correct_line = "Lorem ipsum dolor sit amet 7\n\n"
    get "/lines/7"
    assert_equal(correct_line, response.body)
  end

  test "Index with wrong value" do
    get "/lines/abc"
    assert :bad_request
  end

  test "Index out of range" do
    get "/lines/201"
    assert :payload_to_large
  end
end
