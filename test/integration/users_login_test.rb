require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  test "login with invalid information" do
      get login_path
      assert_template 'sessions/new'
      get login_path, params: { session: { email: "", password: "" } }
      assert_template 'sessions/new'
      assert_not flash.nil?
      get root_path
      assert flash.empty?
    end
    
    test "login with valid information" do 
      user = users(:konrad)
      post sessions_path, params: { email: user.email, password: 'password' }
      assert_redirected_to root_path 
      follow_redirect!
      assert_select "a[href=?]", logout_path
      assert_select "#sidebar", count: 1
    end
  
end 