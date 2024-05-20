# frozen_string_literal: true

class Bulletin < ApplicationRecord
  belongs_to :user, inverse_of: :bulletins
  belongs_to :category, inverse_of: :bulletins

  has_one_attached :image

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }

  validates :image, attached: true,
                    content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                    size: { less_than: 5.megabytes,
                            message: I18n.t('image_size_message') }

  scope :ordered_bulletins, -> { order(created_at: :desc) }
end
