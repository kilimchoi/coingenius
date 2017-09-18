class Identity < ApplicationRecord
  belongs_to :user

  class << self
    def find_or_create_with_omniauth(auth)
      self.find_with_omniauth(auth) || self.create_with_omniauth(auth)
    end

    def find_with_omniauth(auth)
      find_by(uid: auth['uid'], provider: auth['provider'])
    end

    def create_with_omniauth(auth)
      create(
        uid: auth['uid'],
        provider: auth['provider'],
        refresh_token: auth.credentials.refresh_token,
        access_token: auth.credentials.token
      )
    end
  end
end
