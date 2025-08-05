class Micropost < ApplicationRecord
  IMAGE_DISPLAY_SIZE = [500, 500].freeze
  MICROPOST_PERMIT = %i(content image).freeze
  PAGINATE_PER = 10
  CONTENT_MAX_LENGTH = 140
  IMAGE_MAX_SIZE = 5.megabytes
  VALID_IMAGE_TYPES = %w(image/jpeg image/gif image/png).freeze

  belongs_to :user

  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: IMAGE_DISPLAY_SIZE
  end

  scope :newest, ->{order(created_at: :desc)}

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: CONTENT_MAX_LENGTH}
  validates :image,
            content_type: {in: VALID_IMAGE_TYPES,
                           message: :must_be_valid_image_format},
            size: {less_than: IMAGE_MAX_SIZE,
                   message: :should_be_less_than_5mb}
end
