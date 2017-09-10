module BittrexOrdersHistoryImports
  class ProcessWorker
    include Sidekiq::Worker

    sidekiq_options queue: :bittrex

    def perform(bittrex_orders_history_import_id)
      bittrex_orders_history_import = BittrexOrdersHistoryImport.find_by(bittrex_orders_history_import_id)

      return if bittrex_orders_history_import.blank?

      BittrexOrdersHistoryImports::Process.call(bittrex_orders_history_import: bittrex_orders_history_import)
    end
  end
end
