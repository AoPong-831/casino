require 'test_helper'

class ReceptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get receptions_index_url
    assert_response :success
  end

end
