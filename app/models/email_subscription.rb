class EmailSubscription < ApplicationRecord
  belongs_to :user

  enum kind: {
    weekly_portfolio_report: "weekly_portfolio_report"
  }

  scope :enabled, -> { where(enabled: true) }
end
