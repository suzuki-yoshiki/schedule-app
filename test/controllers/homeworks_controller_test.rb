require 'test_helper'

class HomeworksControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get homeworks_show_url
    assert_response :success
  end

end
