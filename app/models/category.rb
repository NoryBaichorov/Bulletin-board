# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :bulletins, inverse_of: :category, dependent: :destroy

  validates :name, presence: true
end
