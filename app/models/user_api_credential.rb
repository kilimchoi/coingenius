class UserApiCredential < ApplicationRecord
  belongs_to :user

  validates :key, :secret, presence: true

  before_validation :assign_key_and_secret, on: :create

  # Encrypt API secret with a special key which should NEVER change
  attr_encrypted :secret, key: ENV["USER_API_CREDENTIAL_256_BIT_KEY"], if: Rails.env.production?

  private

  def assign_key_and_secret
    self.key = SecureRandom.hex(24)
    self.secret = SecureRandom.hex(64)
  end
end
