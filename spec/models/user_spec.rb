require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username) }

  it { is_expected.to have_many(:bittrex_orders_history_imports) }
  it { is_expected.to have_many(:coins).through(:transactions) }
  it { is_expected.to have_many(:conversions) }
  it { is_expected.to have_many(:email_subscriptions) }
  it { is_expected.to have_many(:identities) }
  it { is_expected.to have_many(:transactions) }
  it { is_expected.to have_many(:weekly_user_transactions_groups) }

  it { is_expected.to have_one(:user_api_credential).dependent(:destroy) }
end
