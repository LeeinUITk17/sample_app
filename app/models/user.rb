class User < ApplicationRecord
  before_save{email.downcase!}
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validate :birthday_in_the_past_100_years
  private
  def birthday_in_the_past_100_years
    return if birthday.blank?

    if birthday > Time.zone.today
      errors.add(:birthday,
                 "can't be in the future")
    end
    return unless birthday < 100.years.ago.to_date

    errors.add(:birthday, "must be within the last 100 years")
  end
end
