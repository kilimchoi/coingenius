module Api
  module V1
    class TransactionsController < Api::V1::ApplicationController
      respond_to :json

      expose :transaction, scope: -> { transactions }
      expose :transactions, -> { current_user.transactions }

      def show
        respond_with transaction
      end

      def index
        respond_with transactions
      end

      def create
        transaction.save

        respond_with transaction, location: api_v1_transaction_url(transaction.id)
      end

      def update
        transaction.update(transaction_params)

        respond_with transaction, location: api_v1_transaction_url(transaction.id)
      end

      delegate :destroy, to: :transaction

      private

      def transaction_params
        params
          .require(:transaction)
          .permit(:amount, :btc_price, :coin_id, :is_expired, :price, :transaction_date, :transaction_type)
      end
    end
  end
end
