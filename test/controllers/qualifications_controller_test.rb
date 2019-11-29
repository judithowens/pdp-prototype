require 'test_helper'

class QualificationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should post qualification" do
    assert_difference('Qualification.count') do
      post user_qualifications_url, params: { user_id: users(:admin).id, qualification: { name: "Mphys Physics", awarded_date: Date.yesterday() } }
    end
    assert_redirected_to user_path(users(:admin))
  end
end
