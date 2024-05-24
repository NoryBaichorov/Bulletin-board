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

  def new?
    create?
  end

  def create?
    user
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
    author?
  end

  def publish?
    admin?
  end

  def reject?
    admin?
  end

  private

  def admin?
    user&.admin
  end

  def author?
    user && bulletin.user == user
  end
end
