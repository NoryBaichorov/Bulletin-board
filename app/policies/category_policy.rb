# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  attr_reader :user, :category

  def initialize(user, category) # rubocop:disable Lint/MissingSuper
    @user = user
    @category = category
  end

  def index?
    admin?
  end

  def new?
    create?
  end

  def create?
    admin?
  end

  def edit?
    update?
  end

  def update?
    admin?
  end

  private

  def admin?
    user&.admin
  end
end
