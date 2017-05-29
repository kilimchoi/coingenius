# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
coins = []
coinbase = Exchange.create(name: "Coinbase", website: "https://www.coinbase.com/")
polo = Exchange.create(name: "Poloniex", website: "https://poloniex.com/")
bitt = Exchange.create(name: "Bittrex", website: "https://bittrex.com/")

btc = Coin.new(name: "Bitcoin", symbol: "BTC", description: "Bitcoin is a cryptocurrency and a digital payment system", website: "https://bitcoin.org/en/ 
", what_is_special_about_it: "First cryptocurrency built on blockchain technology.#Most widely used cryptocurrency in the world.
", consensus_mechanism: "Proof of work", category: "Currency")
btc.exchanges << coinbase
coins << btc 

eth = Coin.new(name: "Ethereum", symbol: "ETH", description: "Ethereum is a decentralized platform that runs smart contracts: applications that run exactly as programmed without any possibility of downtime, censorship, fraud or third party interference.", 
  website: "https://www.ethereum.org/", what_is_special_about_it: "Programmable money-allows other coins to build on top of Ethereum blockchain.#Smart contracts.", 
   consensus_mechanism: "Proof of work", category: "Currency")
eth.exchanges << polo
eth.exchanges << bitt
coins << eth 

xrp = Coin.new(name: "Ripple", symbol: "xrp", description: "Ripple is a real-time gross settlement system (RTGS), currency exchange and remittance network operated by Ripple.", 
  website: "https://ripple.com/", what_is_special_about_it: "Open payment network that aims to move money around seamlessly.#Used by banks for its settlement infrastructure.#Real-time gross settlement system#Founders of Ripple control over 99% of XRP",
  consensus_mechanism: "Ripple Protocol consensus algorithm", category: "Platform")
xrp.exchanges << polo 
xrp.exchanges << bitt
coins << xrp

xem = Coin.new(name: "NEM", symbol: "xem", description: "NEM has a stated goal of a wide distribution model and has introduced new features to blockchain technology such as its proof-of-importance (POI) algorithm, multisignature accounts, encrypted messaging, and an Eigentrust++ reputation system.",
website: "https://www.nem.io/", what_is_special_about_it: "P2P platform that provides payment, messaging, asset making, namespaces and more.#Can send payments and messages securely globally.",
consensus_mechanism: "Proof of importance", category: "Payment Network")
xem.exchanges << polo 
xem.exchanges << bitt 
coins << xem 

ltc = Coin.new(name: "Litecoin", symbol: "LTC", description: "Litecoin is a peer-to-peer Internet currency that enables instant, near-zero cost payments to anyone in the world.",
  website: "https://litecoin.org/", what_is_special_about_it: "Faster transaction time than bitcoin.#Segwit-ready", consensus_mechanism: "Proof of work", 
  category: "currency")
ltc.exchanges << coinbase
ltc.exchanges << polo 
ltc.exchanges << bitt
coins << ltc 

coins.each do |coin| 
  coin.save!
end
