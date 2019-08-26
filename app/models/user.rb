class User < ApplicationRecord
  has_secure_password

  has_many :authentication_tokens

  before_create :set_username

  validates :email, presence: true, uniqueness: true,
                    format: { with: EMAIL_REGEX,
                              message: 'format is invalid' }
  validates_length_of :password, minimum: 8, allow_blank: true
  validates :username, presence: true, on: :update
  validates_length_of :username, minimum: 5, on: :update, if: :username_changed?

  private

  def set_username
    self.username = email.split('@').first
  end
end
