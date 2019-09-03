class AuthenticationToken < ApplicationRecord
  belongs_to :user

  before_create :set_expires_at
  before_create :set_token

  scope :valid, -> { where('expires_at > ?', Time.zone.now) }

  def expire!
    update_columns(expires_at: Time.zone.now)
  end

  private

  def set_expires_at
    self.expires_at = Time.zone.now + 1.day
  end

  def set_token
    self.token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex
      break token unless self.class.where(token: token).exists?
    end
  end
end
