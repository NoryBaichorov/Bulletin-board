# frozen_string_literal: true

require_relative '../test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @bulletin = bulletins(:draft)
    @category = categories(:one)
    @image = fixture_file_upload('test.png', 'image/png')
  end

  test 'should get index' do
    get bulletins_url
    assert_response :success
  end

  test 'should get new' do
    sign_in @user
    get new_bulletin_url
    assert_response :success
  end

  test 'should not get new if unauthorized user' do
    get new_bulletin_url
    assert_response :redirect
    assert_redirected_to root_url
  end

  test 'should create bulletin' do
    @attrs = {
      title: Faker::Movies::HarryPotter.character,
      description: Faker::Lorem.paragraph_by_chars(number: 256),
      category_id: @category.id,
      user_id: @user.id
    }

    sign_in @user
    post bulletins_url, params: { bulletin: @attrs.merge(image: @image) }

    new_bulletin = Bulletin.find_by @attrs
    assert_redirected_to bulletin_url(new_bulletin)
  end

  # test 'should show post' do
  #   sign_in @user
  #   get bulletin_url(@bulletin)
  #   assert_response :success
  # end
end
