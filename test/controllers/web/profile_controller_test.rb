# frozen_string_literal: true

require_relative '../../test_helper'

class Web::ProfileControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user)
  end

  test 'should get index' do
    sign_in @user

    get profile_path
    assert_response :success
  end

  test 'should not get index if unauthorized' do
    get profile_path

    assert_response :redirect
    assert_redirected_to root_path
  end
end
