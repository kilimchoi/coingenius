class UserApiCredential < ActiveRecord::Base
  belongs_to :user

  validates :key, :secret, :user_id, presence: true

  before_validation :assign_key_and_secret, on: :create

  # Encrypt key and secret with a special key which should NEVER change
  with_options(key: ENV["USER_API_CREDENTIAL_256_BIT_KEY"], if: Rails.env.production?) do
    attr_encrypted :key
    attr_encrypted :secret
  end

  private

  def assign_key_and_secret
    self.key = SecureRandom.hex(24)
    self.secret = SecureRandom.hex(64)
  end
end
