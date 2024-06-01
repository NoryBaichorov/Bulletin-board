# frozen_string_literal: true

require_relative '../../../test_helper'

class Web::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)

    @category = categories(:one)
    @category_two = categories(:two)

    @attrs = { name: Faker::Movies::HarryPotter.character }
  end

  test 'should get index' do
    sign_in @admin

    get admin_categories_path
    assert_response :success
  end

  test 'should get new' do
    sign_in @admin

    get new_admin_category_path
    assert_response :success
  end

  test 'should get edit' do
    sign_in @admin

    get edit_admin_category_path(@category)
    assert_response :success
  end

  test 'should update category' do
    sign_in @admin
    patch admin_category_path(@category), params: { category: @attrs }

    @category.reload

    assert @category.name == @attrs[:name]
    assert_redirected_to admin_categories_path
  end

  test 'should create category' do
    sign_in @admin
    post admin_categories_path, params: { category: @attrs }

    new_category = Category.find_by @attrs

    assert new_category
    assert_redirected_to admin_categories_path
  end

  test 'should destroy category' do
    sign_in @admin

    delete admin_category_path(@category_two)

    assert_not Category.find_by(id: @category_two.id)
    assert_redirected_to admin_categories_path
  end

  test 'should not destroy if category has bulletins' do
    sign_in @admin

    delete admin_category_path(@category)

    assert Category.find_by(id: @category.id)
    assert_redirected_to admin_categories_path
  end
end
