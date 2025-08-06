class User < ApplicationRecord
  PASSWORD_LENGTH_MIN = 6
  NAME_LENGTH_MAX = 50
  EMAIL_LENGTH_MAX = 255
  PAGINATE_PER = 10
  AVATAR_PROFILE_SIZE = 150
  AVATAR_SIZE_LIST = 50
  PASSWORD_RESET_EXPIRES_IN = 2.hours
  MAX_YEARS_AGO_FOR_BIRTHDAY = 100.years
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  USER_PERMIT = %i(name email password password_confirmation birthday gender
avatar).freeze

  attr_accessor :remember_token, :activation_token, :reset_token

  has_many :microposts, dependent: :destroy
  has_many :active_relationships,  class_name:  Relationship.name,
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  Relationship.name,
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_one_attached :avatar
  has_secure_password
  enum gender: {female: 0, male: 1, other: 2}

  before_save   :downcase_email
  before_create :create_activation_digest

  scope :newest, ->{order(created_at: :desc)}

  validates :name, presence: true, length: {maximum: NAME_LENGTH_MAX}
  validates :email, presence: true, length: {maximum: EMAIL_LENGTH_MAX},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
length: {minimum: PASSWORD_LENGTH_MIN}, allow_nil: true

  validate :birthday_in_the_past_100_years

  def follow other_user
    following << other_user unless self == other_user
  end

  def unfollow other_user
    following.delete(other_user)
  end

  def following? other_user
    following.include?(other_user)
  end

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

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest:  User.digest(reset_token),
                   reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < PASSWORD_RESET_EXPIRES_IN.ago
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
             .includes(:user, image_attachment: :blob).newest
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def birthday_in_the_past_100_years
    return if birthday.blank?

    errors.add(:birthday, :in_the_future) if birthday > Time.zone.today
    return unless birthday < MAX_YEARS_AGO_FOR_BIRTHDAY.ago.to_date

    errors.add(:birthday, :not_in_100_years)
  end
end
