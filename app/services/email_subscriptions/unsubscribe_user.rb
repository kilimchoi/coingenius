module EmailSubscriptions
  class UnsubscribeUser
    include Interactor

    delegate :email, :tags, :user, to: :context

    before do
      context.user = User.find_by(email: email)
    end

    def call
      return unless user

      EmailSubscription
        .where(kind: tags, user: user)
        .update(enabled: false)
    end
  end
end
