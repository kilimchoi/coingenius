
class FetchPriceDataForCoinWorker
  include Sidekiq::Worker

  sidekiq_options queue: :coin_price, retry: 5

  def perform(coin_symbol, price_history_key)
    puts 'enters here ', coin_symbol
   
    days = get_365_days 
    days.each do |ts|
      key = price_history_key.concat(ts.to_s)
      val = $redis.get(key)
      if val.nil?
        response = HTTParty.get("https://min-api.cryptocompare.com/data/pricehistorical?fsym=#{coin_symbol.upcase}&tsyms=USD&ts=#{ts}")
        response = JSON.parse(response.body).with_indifferent_access["#{coin_symbol.upcase}"]["USD"]
        $redis.set(key, response)
        $redis.expire(key, 1.day.to_i)
      end
      key = price_history_key
    end
  end

  def get_365_days
    a = []
    365.downto(1) do |i|
      a << (Time.now - i.day).strftime("%Y-%m-%d")
    end
    a.map {|t| t.to_time.to_i}
  end
end
