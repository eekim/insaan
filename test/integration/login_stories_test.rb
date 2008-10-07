require "#{File.dirname(__FILE__)}/../test_helper"

class LoginStoriesTest < ActionController::IntegrationTest
  fixtures :users

  def test_valid_login
    get edit_user_url(1)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template 'sessions/new'

    go_to_login

    login :login => 'quentin', :password => 'test'

    get edit_user_url(1)
    assert_response :success
    assert_template 'users/edit'
  end

  private

  def go_to_login
    get 'sessions/new'
    assert_response :success
    assert_template 'sessions/new'
  end

  def login(options)
    post 'sessions/create', options
    assert_response :redirect
  end

end
