# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, inverse_of: :user, dependent: :destroy

  validates :email, uniqueness: true
end
