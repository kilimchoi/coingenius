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

etc = Coin.new(name: "Ethereum Classic", symbol: "ETC", description: "Ethereum Classic is a decentralized platform that runs smart contracts: applications that run exactly as programmed without any possibility of downtime, censorship, fraud or third party interference.", website: "https://ethereumclassic.github.io/",
  what_is_special_about_it: "Continuation of the original Ethereum blockchain - the classic version preserving untampered history", consensus_mechanism: "CryptoNight proof of work", category: "Currency")
etc.exchanges << bitt
etc.exchanges << polo 

dash = Coin.new(name: "Dash", symbol: "DASH", description: "Dash (formerly known as Darkcoin and XCoin) is an open source peer-to-peer cryptocurrency that offers instant transactions (InstantSend), private transactions (PrivateSend) and token fungibility.", 
  website: "https://www.dash.org/", what_is_special_about_it: "Focused on privacy and instantaneous payment.", consensus_mechanism: "Proof of work", category: "Payment Network")
dash.exchanges << bitt 
dash.exchanges << polo 

xmr = Coin.new(name: "Monero", symbol: "XMR", description: "Monero (XMR) is a privacy-focused cryptocurrency that is not based on Bitcoin's code. Monero aims to be a fungible and untraceable digital medium of exchange.", website: "https://getmonero.org", 
  what_is_special_about_it: "Second most used cryptocurrency in the dark web.#Unttraceable transaction history.#Cryptonote-based#Forked from Bytecoin",
  consensus_mechanism: "CryptoNight proof of work", category: "Currency")
xmr.exchanges << bitt
xmr.exchanges << polo 

bcn = Coin.new(name: "Bytecoin", symbol: "BCN", description: "Bytecoin allows safe and secure transactions around the globe and offers the convenience of instant fee-free money transactions.", what_is_special_about_it: "Free instant international payments.#Unntraceable transaction history.#80%+ were premined prior to public release.#Cryptonote-based",
  website: "https://bytecoin.org/", consensus_mechanism: "CryptoNight Proof of work", category: "Payment Network")
bcn.exchanges << bitt 
bcn.exchanges << polo 

xlm = Coin.new(name: "Stellar Lumens", symbol: "XLM", description: "Stellar is a platform that connects banks, payments systems, and people.", what_is_special_about_it: "Aims to connect individuals to low-cost financial services.#Instant payment (2-5 seconds), customizable payment infrastructure.#Premined coins.",
  website: "https://www.stellar.org/", consensus_mechanism: "Stellar Consensus Protocol", category: "Payment Network")
xlm.exchanges << bitt
xlm.exchanges << polo 

doge = Coin.new(name: "Dogecoin", symbol: "DOGE", description: "Dogecoin is a cryptocurrency featuring a likeness of the Shiba Inu dog from the 'Doge' Internet meme as its logo.", what_is_special_about_it: "Coin with a logo of Shiba Inu.#Primarily used to send payments online.", 
  website: "http://dogecoin.com/", consensus_mechanism: "Proof of work", category: "Currency")
doge.exchanges << bitt 
doge.exchanges << polo 

gnt = Coin.new(name: "Golem", symbol: "GNT", description: "Golem is a global, open sourced, decentralized supercomputer that anyone can access. It's made up of the combined power of user's machines, from personal laptops to entire datacenters.", what_is_special_about_it: "Decentralized supercomputer powered by individual's machines.#Get rewarded for renting your computer power.",
  website: "https://golem.network/", consensus_mechanism: "Unknown", category: "Computing Power Network")
gnt.exchanges << bitt 
gnt.exchanges << polo 

rep = Coin.new(name: "Augur", symbol: "REP", description: "Augur is a fully open-source and decentralized prediction market platform built on Ethereum, a blockchain technology that allows for the execution of smart contracts.", what_is_special_about_it: "Decentralized prediction market.#It allows you to forecast events and be rewarded for predicting the outcome correctly.",
  website: "https://augur.net/", consensus_mechanism: "Proof of work", category: "Prediction Market")
rep.exchanges << bitt
rep.exchanges << polo 

zec = Coin.new(name: "Zcash", symbol: "ZEC", description: "Zcash is the first open, permissionless cryptocurrency that can fully protect the privacy of transactions using zero-knowledge cryptography.", what_is_special_about_it: "First fully anonymous coin", 
  website: "https://z.cash/", consensus_mechanism: "Proof of work", category: "Currency")
zec.exchanges << bitt 
zec.exchanges << polo 

strat = Coin.new(name: "Stratis", symbol: "STRAT", description: "Stratis offers full service capabilities for the development, deployment and management of blockchain applications and solutions utilizing C# on the .Net framework.", what_is_special_about_it: "Block chain as a service.#Built with C sharp & .Net.#Goal is to make it easier for companies to build their services on top of blockchain.#Segwit-ready.", 
  website: "https://stratisplatform.com/", consensus_mechanism: "Proof of stake", category: "Platform")
strat.exchanges << bitt 
strat.exchanges << polo 

steem = Coin.new(name: "Steem", symbol: "STEEM", description: "Steem is a blockchain-based social media platform where anyone can earn rewards.", 
  website: "https://steem.io/", consensus_mechanism: "Proof of work", category: "Currency")
steem.exchanges << bitt 
steem.exchanges << polo 

gno = Coin.new(name: "Gnosis", symbol: "GNO", description: "Based on Ethereum — The next generation blockchain network. Speculate on anything with an easy-to-use prediction market.", what_is_special_about_it: "Prediction market that rewards users for predicing the event outcome correctly, from sports betting to politics.",
  website: "https://gnosis.pm/", consensus_mechanism: "Unknown", category: "Prediction Market")
gno.exchanges << bitt
gno.exchanges << polo 

waves = Coin.new(name: "Waves", symbol: "WAVES", description: "Crypto-platform for asset/custom token issuance, transfer and trading on blockchain",
  what_is_special_about_it: "Decentralized crowd-funding platform.#Allow for trading tokens of value on a decentralized network like btc, USD, etc.#Gateways enable users to hold tokens representing anything from currency to physical properties.#Have their own decentralized exchange.",
  website: "https://wavesplatform.com/", consensus_mechanism: "Unknown", category: "Platform")
waves.exchanges << bitt 

bts = Coin.new(name: "Bitshares", symbol: "BTS", description: "BitShares is a distributed multi-user database with update permissions managed by a defined set of rules and public key cryptography.",
  what_is_special_about_it: "Smart contract platform.#Dynamic account permissions.#Transferable named accounts.", website: "https://bitshares.org/", consensus_mechanism: "Delegated proof of stake", category: "Platform")
bts.exchanges << polo 

sia = Coin.new(name: "Siacoin", symbol: "SC", description: "Sia is a decentralized network of datacenters that, taken together, comprise the world's fastest, cheapest, and most secure cloud storage platform.",
  what_is_special_about_it: "Private secure cloud storage cheaper than AWS S3", website: "http://sia.tech/", category: "Storage Network", consensus_mechanism: "Proof of work")
sia.exchanges << polo
sia.exchanges << bitt 

lykke = Coin.new(name: "Lykke", symbol: "LKK", description: "Next-generation trading platform with zero commission.", what_is_special_about_it: "Coin represents ownership in the Swiss-based corp, Lykke.#No mining available.#Not a currency.#Not a stock.#You can trade colored coins that are associated with physical assets like company stocks, other cryptocurrencies and forex markets.#Coin is available via their mobile app", 
  website: "https://www.lykke.com/", category: "Exchange", consensus_mechanism: "N/A")

coins.each do |coin| 
  coin.save!
end
