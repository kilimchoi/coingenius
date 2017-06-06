class Coin < ActiveRecord::Base
  has_and_belongs_to_many :exchanges
  has_many :transactions

  attr_accessor :price, :percent_change, :market_cap

  def label
    "#{name} (#{symbol})"
  end

  def price_history
    if history = $redis.get(price_history_key)
      puts history
      JSON.parse(history).with_indifferent_access
    else
      response = HTTParty.get("https://min-api.cryptocompare.com/data/histoday?fsym=#{symbol}&tsym=USD&limit=7&aggregate=1&e=CCCAGG")
      response = JSON.parse(response.body).with_indifferent_access
      $redis.set(price_history_key, response.to_json)
      $redis.expire(price_history_key, 1.day.to_i)
      response
    end
  end

  def price_history_key
    "#{symbol}_price_history"
  end

  def self.colors
    [
      '#768b97', 
      '#b9553f', 
      '#e2a89f', 
      '#7ba0cf', 
      '#bb9c8b', 
      '#5118e9', 
      '#a0a2dc', 
      '#d3992a', 
      '#565d51', 
      '#6ae021', 
      '#e45221', 
      '#cd82e5', 
      '#dbcabf', 
      '#d37193', 
      '#cbd834', 
      '#a63c72', 
      '#7ffb7d', 
      '#357130', 
      '#ee10d7', 
      '#411ead', 
      '#140d5c',
      '#8ecdf6', 
      '#06c25a', 
      '#f2548b', 
      '#7dde0e', 
      '#506b45', 
      '#15ad8b', 
      '#99874d', 
      '#b1fb4f', 
      '#d5b5a6', 
      '#eda77d', 
      '#6ada1b', 
      '#9ea709', 
      '#4c186b', 
      '#ea0def', 
      '#96c9fb', 
      '#cc7298', 
      '#20c6b9', 
      '#8dcb03', 
      '#f45f0e', 
      '#8d3c2b', 
      '#fa4d93',
    ]
  end
end
