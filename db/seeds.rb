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

btc = Coin.new(
  name: "Bitcoin", 
  symbol: "BTC", 
  description: "Bitcoin is a cryptocurrency and a digital payment system", 
  website: "https://bitcoin.org/en/", 
  pros: "First cryptocurrency built on blockchain.#Most widely used cryptocurrency#Largest developer community.", 
  cons: "Slow transaction time.#Not segwit-ready.", 
  consensus_mechanism: "Proof of work", 
  category: "Currency")
btc.exchanges << coinbase
coins << btc 

eth = Coin.new(
  name: "Ethereum", 
  symbol: "ETH", 
  description: "Ethereum is a decentralized platform that runs smart contracts: applications that run exactly as programmed without any possibility of downtime, censorship, fraud or third party interference.", 
  website: "https://www.ethereum.org/", 
  pros: "Programmable money.#Smart contracts.#Huge community - Ethereum Enterprise Alliance consists of companies like Microsoft, Intel, and more.", 
  cons: "Higher inflation than bitcoin.#Faster TPS than bitcoin but slower than NEM.", 
  consensus_mechanism: "Proof of work", 
  category: "Currency")
eth.exchanges << polo
eth.exchanges << bitt
coins << eth 

xrp = Coin.new(
  name: "Ripple", 
  symbol: "xrp", 
  description: "Ripple is a real-time gross settlement system (RTGS), currency exchange and remittance network operated by Ripple.", 
  website: "https://ripple.com/", 
  pros: "Open payment network with real-time gross settlement system.#Math-based currency.#Free from DoS attacks.#Its settlement infrastructure is used by banks.",
  cons:"Founders of Ripple control over 99% of XRP.", 
  consensus_mechanism: "Ripple Protocol consensus algorithm", 
  category: "Platform")
xrp.exchanges << polo 
xrp.exchanges << bitt
coins << xrp

xem = Coin.new(
  name: "NEM", 
  symbol: "xem", 
  description: "NEM has a stated goal of a wide distribution model and has introduced new features to blockchain technology such as its proof-of-importance (POI) algorithm, multisignature accounts, encrypted messaging, and an Eigentrust++ reputation system.",
  website: "https://www.nem.io/", 
  pros: "P2P platform that provides payment, messaging and more.#Can send payments and messages securely globally.#Incredibly scalable - 3000 transactions/sec/.#Low transaction fee - 0.01% fee.", 
  cons:"No private transactions.#No mining available.",
  consensus_mechanism: "Proof of importance", 
  category: "Payment Network")
xem.exchanges << polo 
xem.exchanges << bitt 
coins << xem 

ltc = Coin.new(
  name: "Litecoin", 
  symbol: "LTC", 
  description: "Litecoin is a peer-to-peer Internet currency that enables instant, near-zero cost payments to anyone in the world.",
  website: "https://litecoin.org/", 
  pros: "Faster transaction time than bitcoin.#Also can handle more transactions than bitcoin.#Segwit-ready.", 
  cons: "No other usecases other than storage of value.",
  consensus_mechanism: "Proof of work", 
  category: "currency")
ltc.exchanges << coinbase
ltc.exchanges << polo 
ltc.exchanges << bitt
coins << ltc 

etc = Coin.new(
  name: "Ethereum Classic", 
  symbol: "ETC", 
  description: "Ethereum Classic is a decentralized platform that runs smart contracts: applications that run exactly as programmed without any possibility of downtime, censorship, fraud or third party interference.", website: "https://ethereumclassic.github.io/",
  website: "https://ethereumclassic.github.io/",
  pros: "Continuation of the original Ethereum blockchain - the classic version preserving untampered history.", 
  cons: "Toxic community of developers who are against Ethereum.",
  consensus_mechanism: "CryptoNight proof of work", 
  category: "Currency")
etc.exchanges << bitt
etc.exchanges << polo 

dash = Coin.new(
  name: "Dash", 
  symbol: "DASH", 
  description: "Dash (formerly known as Darkcoin and XCoin) is an open source peer-to-peer cryptocurrency that offers instant transactions (InstantSend), private transactions (PrivateSend) and token fungibility.", 
  website: "https://www.dash.org/", 
  pros: "Instantaneous transaction time about 1.2 seconds.#Private transaction possible with privatesend.#Low transaction fee.", 
  cons: "Core team is secretive about their roadmaps.#Decentralized governance is immature - few masternode owners make the decision ",
  consensus_mechanism: "Proof of work", 
  category: "Payment Network")
dash.exchanges << bitt 
dash.exchanges << polo 

xmr = Coin.new(
  name: "Monero", 
  symbol: "XMR", 
  description: "Monero (XMR) is a privacy-focused cryptocurrency that is not based on Bitcoin's code. Monero aims to be a fungible and untraceable digital medium of exchange.", website: "https://getmonero.org", 
  website: "https://getmonero.org",
  pros: "Unttraceable payments & Unlinkable transactions.#Wide adoption-second most used cryptocurrency in the dark web.#Cryptonote-based.",
  cons: "Untraceability makes it challenging to go mainstream.",
  consensus_mechanism: "CryptoNight proof of work", 
  category: "Currency")
xmr.exchanges << bitt
xmr.exchanges << polo 

bcn = Coin.new(
  name: "Bytecoin", 
  symbol: "BCN", 
  description: "Bytecoin allows safe and secure transactions around the globe and offers the convenience of instant fee-free money transactions.", 
  pros: "Free instant international payments.#Unntraceable payment.#Cryptonote-based.",
  cons: "80%+ were premined prior to public release.",
  website: "https://bytecoin.org/", 
  consensus_mechanism: "CryptoNight Proof of work", 
  category: "Payment Network")
bcn.exchanges << bitt 
bcn.exchanges << polo 

xlm = Coin.new(
  name: "Stellar Lumens", 
  symbol: "XLM", 
  description: "Stellar is a platform that connects banks, payments systems, and people.", 
  website: "https://www.stellar.org/", 
  pros: "Instant payment (2-5 seconds).#customizable payment infrastructure.",
  cons: "No mining available.#95% of Lumens were given out.",
  consensus_mechanism: "Stellar Consensus Protocol", 
  category: "Payment Network")
xlm.exchanges << bitt
xlm.exchanges << polo 

doge = Coin.new(
  name: "Dogecoin", 
  symbol: "DOGE", 
  description: "Dogecoin is a cryptocurrency featuring a likeness of the Shiba Inu dog from the 'Doge' Internet meme as its logo.", 
  website: "http://dogecoin.com/", 
  pros: "Easy to send payments online.", 
  cons: "Coin is not taken seriously.#No unique technical feature.", 
  consensus_mechanism: "Proof of work", 
  category: "Currency")
doge.exchanges << bitt 
doge.exchanges << polo 

gnt = Coin.new(
  name: "Golem", 
  symbol: "GNT",
  escription: "Golem is a global, open sourced, decentralized supercomputer that anyone can access. It's made up of the combined power of user's machines, from personal laptops to entire datacenters.", 
  pros: "It rewards you for renting out computing power.",
  cons: "No Mining available.",
  website: "https://golem.network/", 
  consensus_mechanism: "Unknown", 
  category: "Computing Power Network")
gnt.exchanges << bitt 
gnt.exchanges << polo 

rep = Coin.new(
  name: "Augur", 
  symbol: "REP", 
  description: "Augur is a fully open-source and decentralized prediction market platform built on Ethereum, a blockchain technology that allows for the execution of smart contracts.", 
  pros: "It allows you to forecast events and be rewarded for predicting the outcome correctly.",
  cons: "Not much activity in the prediction market.",
  website: "https://augur.net/", 
  consensus_mechanism: "Proof of work", 
  category: "Prediction Market")
rep.exchanges << bitt
rep.exchanges << polo 

zec = Coin.new(
  name: "Zcash", 
  symbol: "ZEC", 
  description: "Zcash is the first open, permissionless cryptocurrency that can fully protect the privacy of transactions using zero-knowledge cryptography.", 
  pros: "Unttraceable payments & Unlinkable transactions.", 
  cons: "20% of block reward goes to the developers.",
  website: "https://z.cash/", 
  consensus_mechanism: "Proof of work", 
  category: "Currency")
zec.exchanges << bitt 
zec.exchanges << polo 

strat = Coin.new(
  name: "Stratis", 
  symbol: "STRAT", 
  description: "Stratis offers full service capabilities for the development, deployment and management of blockchain applications and solutions utilizing C# on the .Net framework.", 
  pros: "Block chain as a service.(Private & public blockchains for corps)#Segwit-ready.#Master nodes provide extra services like making the network transactions more private, enabling instant transactions, etc.", 
  cons: "No customers as May 29th 2017.",
  website: "https://stratisplatform.com/", 
  consensus_mechanism: "Proof of stake", 
  category: "Platform")
strat.exchanges << bitt 
strat.exchanges << polo 

steem = Coin.new(
  name: "Steem", 
  symbol: "STEEM", 
  description: "Steem is a blockchain-based social media platform where anyone can earn rewards.",
  pros: "Content creators on steemit.io get rewarded when their posts get upvoted.",
  cons: "Vulnerable to voting manipulation via sybil attack.",
  website: "https://steem.io/", 
  consensus_mechanism: "Proof of work", 
  category: "Currency")
steem.exchanges << bitt 
steem.exchanges << polo 

gno = Coin.new(
  name: "Gnosis", 
  symbol: "GNO", 
  description: "Based on Ethereum — The next generation blockchain network. Speculate on anything with an easy-to-use prediction market.", 
  pros: "Can create customised prediction market app,",
  cons: "No known Gnosis-powered apps,",
  website: "https://gnosis.pm/", 
  consensus_mechanism: "Unknown", 
  category: "Prediction Market")
gno.exchanges << bitt
gno.exchanges << polo 

waves = Coin.new(
  name: "Waves", 
  symbol: "WAVES", 
  description: "Crypto-platform for asset/custom token issuance, transfer and trading on blockchain",
  pros: "Allows for trading on its decentralized exchange.#Straightforward custom token creation process.#Fast transactions and future-proof scaling.#Friendly community.",
  cons: "Many fake coins created as a result of easy creation process",
  website: "https://wavesplatform.com/", 
  consensus_mechanism: "Unknown", 
  category: "Platform")
waves.exchanges << bitt 

bts = Coin.new(
  name: "Bitshares", 
  symbol: "BTS", 
  description: "BitShares is a distributed multi-user database with update permissions managed by a defined set of rules and public key cryptography.",
  pros: "Allows for trading on its decentralized exchange.#Extremely fast transaction time - handles tens of thousands/sec.#Allows for creation of smartcoins and user-issued assets akin to Waves' custom tokens.", 
  cons: "Declining developer interest.#Main developer left for Steem.",
  website: "https://bitshares.org/", 
  consensus_mechanism: "Delegated proof of stake", 
  category: "Platform")
bts.exchanges << polo 

sia = Coin.new(
  name: "Siacoin", 
  symbol: "SC", 
  description: "Sia is a decentralized network of datacenters that, taken together, comprise the world's fastest, cheapest, and most secure cloud storage platform.",
  pros: "You get rewarded for renting out your computer storage.#Files are split across the network & encrypted so no need to worry about privacy.", 
  cons: "Low adoption due to people feeling uncomfortable renting out storage for storing illegal content",
  website: "http://sia.tech/", 
  category: "Storage Network", 
  consensus_mechanism: "Proof of work")
sia.exchanges << polo
sia.exchanges << bitt 

lykke = Coin.new(
  name: "Lykke", 
  symbol: "LKK", 
  description: "Next-generation trading platform with zero commission.", 
  pros: "You can trade colored coins that are associated with physical assets.#0 trading fees.#Each Lykke coin represents a share in the company.", 
  cons: "No mining available.#Coin is available only via their mobile app.#Not available in the US.",
  website: "https://www.lykke.com/", 
  category: "Exchange", 
  consensus_mechanism: "N/A")

coins.each do |coin| 
  coin.save!
end
