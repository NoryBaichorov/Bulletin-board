# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  attr_reader :user, :bulletin

  def initialize(user, bulletin) # rubocop:disable Lint/MissingSuper
    @user = user
    @bulletin = bulletin
  end

  def index?
    admin?
  end

  def show?
    published_bulletin? || author? || admin?
  end

  def new?
    user
  end

  def create?
    new?
  end

  def edit?
    update?
  end

  def update?
    author?
  end

  def to_moderate?
    author?
  end

  def archive?
    admin? || author?
  end

  private

  def admin?
    user&.admin?
  end

  def author?
    user && bulletin.user == user
  end

  def published_bulletin?
    bulletin&.published?
  end
end
