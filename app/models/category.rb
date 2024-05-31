# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :bulletins # rubocop:disable Rails/HasManyOrHasOneDependent

  validates :name, presence: true
end
