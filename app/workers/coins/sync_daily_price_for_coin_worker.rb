module Coins
  class SyncDailyPriceForCoinWorker
    include Sidekiq::Worker
    sidekiq_options retry: 5

    def perform(coin_id)
      puts 'enters perform!!!!'
      coin = Coin.find_by(id: coin_id)
      response = HTTParty.get("https://min-api.cryptocompare.com/data/price?fsym=#{coin.symbol.upcase}&tsyms=USD")
      price = JSON.parse(response.body).with_indifferent_access["USD"]
      key = price_today_key(coin.symbol)
      puts 'key is ', key
      puts 'price is ', price
      $redis.set(key, price)
      $redis.expire(key, 5.minutes)
    end
    
    private

    def price_today_key(symbol)
      "#{symbol}_price_today"
    end
  end
end
