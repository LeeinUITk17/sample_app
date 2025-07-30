class User < ApplicationRecord
  PASSWORD_LENGTH_MIN = 6
  NAME_LENGTH_MAX = 50
  EMAIL_LENGTH_MAX = 255
  PAGINATE_PER = 10
  AVATAR_SIZE_LIST = 50
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  USER_PERMIT = %i(name email password password_confirmation birthday gender
avatar).freeze

  attr_accessor :remember_token

  has_one_attached :avatar
  has_secure_password
  enum gender: {female: 0, male: 1, other: 2}

  before_save{email.downcase!}

  scope :newest, ->{order(created_at: :desc)}

  validates :name, presence: true, length: {maximum: NAME_LENGTH_MAX}
  validates :email, presence: true, length: {maximum: EMAIL_LENGTH_MAX},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: PASSWORD_LENGTH_MIN},
allow_nil: true

  validate :birthday_in_the_past_100_years

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost:)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated? remember_token
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  def birthday_in_the_past_100_years
    return if birthday.blank?

    errors.add(:birthday, :in_the_future) if birthday > Time.zone.today
    return unless birthday < 100.years.ago.to_date

    errors.add(:birthday, :not_in_100_years)
  end
end
