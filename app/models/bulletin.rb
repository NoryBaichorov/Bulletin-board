# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  belongs_to :user, inverse_of: :bulletins
  belongs_to :category, inverse_of: :bulletins

  has_one_attached :image

  aasm column: 'state' do
    state :draft, initial: true
    state :under_moderate, :published, :rejected, :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderate
    end

    event :publish do
      transitions from: :under_moderate, to: :published
    end

    event :reject do
      transitions from: :under_moderate, to: :rejected
    end

    event :archive do
      transitions from: %i[draft under_moderate published rejected], to: :archived
    end
  end

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }

  validates :image, attached: true,
                    content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                    size: { less_than: 5.megabytes,
                            message: I18n.t('image_size_message') }

  scope :order_by_desc, -> { order(created_at: :desc) }
  scope :published_bulletins, -> { where(state: :published) }
  scope :under_moderate_bulletins, -> { where(state: :under_moderate) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[state title category_id]
  end
end
