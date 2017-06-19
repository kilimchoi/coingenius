
class FetchPriceDataForCoinsWorker
  include Sidekiq::Worker
  sidekiq_options queue: :coin_price, retry: 5

  def perform
    coins = Coin.all 
    puts 'enters perform'
    coins.each do |coin|
      price_history_key = "#{coin.symbol}_price_history"
      puts 'coin symbol is ', coin.symbol
      FetchPriceDataForCoinWorker.perform_async(coin.symbol, price_history_key)
    end 
  end
end
