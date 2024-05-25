# frozen_string_literal: true

require_relative '../../../test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @archived_bulletin = bulletins(:archived)
    @published_bulletin = bulletins(:published)
    @rejected_bulletin = bulletins(:rejected)
    @under_moderate_bulletin = bulletins(:under_moderate)

    @admin = users(:admin)
    @user = users(:user)
  end

  test 'should get under_moderate index' do
    sign_in @admin

    get admin_root_path
    assert_response :success
  end

  test 'should get all bulletin index' do
    sign_in @admin

    get admin_bulletins_path
    assert_response :success
  end

  test 'should not get bulletin index if not admin' do
    sign_in @user

    get admin_bulletins_path

    assert_response :redirect
    assert_redirected_to root_path
  end

  test 'should set state published' do
    sign_in @admin
    patch publish_admin_bulletin_path(@under_moderate_bulletin)

    @under_moderate_bulletin.reload

    assert @under_moderate_bulletin.published?
    assert_redirected_to admin_root_path
  end

  test 'should not set state published if not admin' do
    sign_in @user
    patch publish_admin_bulletin_path(@under_moderate_bulletin)

    assert_response :redirect
    assert_redirected_to root_path
  end

  test 'should set state rejected' do
    sign_in @admin
    patch reject_admin_bulletin_path(@under_moderate_bulletin)

    @under_moderate_bulletin.reload

    assert @under_moderate_bulletin.rejected?
    assert_redirected_to admin_root_path
  end

  test 'should not set state rejected if not admin' do
    sign_in @user
    patch reject_admin_bulletin_path(@under_moderate_bulletin)

    assert_response :redirect
    assert_redirected_to root_path
  end

  test 'should set state archived' do
    sign_in @admin
    patch archive_admin_bulletin_path(@under_moderate_bulletin)

    @under_moderate_bulletin.reload
    assert @under_moderate_bulletin.archived?
    assert_redirected_to admin_root_path
  end

  test 'should not set state archived if not admin' do
    sign_in @user
    patch archive_admin_bulletin_path(@under_moderate_bulletin)
    @under_moderate_bulletin.reload

    assert_response :redirect
    assert_redirected_to root_path
  end

  test 'should not set state archived if already archived' do
    sign_in @admin
    patch archive_admin_bulletin_path(@archived_bulletin)

    assert_response :redirect
    assert_redirected_to admin_root_path
  end

  test 'should not set state published if already published' do
    sign_in @admin
    patch publish_admin_bulletin_path(@published_bulletin)

    assert_response :redirect
    assert_redirected_to admin_root_path
  end

  test 'should not set state rejected if already rejected' do
    sign_in @admin
    patch reject_admin_bulletin_path(@rejected_bulletin)

    assert_response :redirect
    assert_redirected_to admin_root_path
  end
end
