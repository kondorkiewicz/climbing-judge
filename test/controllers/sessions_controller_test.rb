require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  test 'should redirect to root path if a logged in user visits the login page' do
      get login_url, params: { user_id: 42 }
      assert_redirected_to root_url, 'Did not redirect'
    end
  
end 