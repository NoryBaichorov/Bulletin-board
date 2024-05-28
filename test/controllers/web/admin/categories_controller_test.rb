# frozen_string_literal: true

require_relative '../../../test_helper'

class Web::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @user = users(:user)

    @category = categories(:one)

    @attrs = { name: Faker::Movies::HarryPotter.character }
  end

  test 'should get index' do
    sign_in @admin

    get admin_categories_path
    assert_response :success
  end

  test 'should not get index if not admin' do
    sign_in @user

    get admin_categories_path

    assert_response :redirect
    assert_redirected_to root_path
  end

  test 'should get new' do
    sign_in @admin

    get new_admin_category_path
    assert_response :success
  end

  test 'should not get new if not admin' do
    sign_in @user
    get new_admin_category_path

    assert_response :redirect
    assert_redirected_to root_path
  end

  test 'should update category' do
    sign_in @admin
    patch admin_category_path(@category), params: { category: @attrs }

    @category.reload

    assert @category.name == @attrs[:name]
    assert_redirected_to admin_categories_path
  end

  test 'should not update category if not admin' do
    sign_in @user
    patch admin_category_path(@category), params: { category: @attrs }

    assert_response :redirect
    assert_redirected_to root_path
  end

  test 'should create category' do
    sign_in @admin
    post admin_categories_path, params: { category: @attrs }

    new_category = Category.find_by @attrs

    assert new_category[:name] == @attrs[:name]
    assert_redirected_to admin_categories_path
  end

  test 'should not create category if not admin' do
    sign_in @user
    post admin_categories_path, params: { category: @attrs }

    assert_response :redirect
    assert_redirected_to root_path
  end
end
