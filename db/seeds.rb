# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
coins = []
coinbase = Exchange.create(name: "Coinbase", website: "https://www.coinbase.com/join/52893754c1edbc9eee000481")
polo = Exchange.create(name: "Poloniex", website: "https://poloniex.com/?ref=coingenius.io")
bitt = Exchange.create(name: "Bittrex", website: "https://bittrex.com/?ref=coingenius.io")
exchanges = []

gemini = Exchange.new(
    name: "Gemini",
    website: "https://gemini.com/?ref=coingenius.io",
    description: "The next generation digital asset platform built for businesses and investors. Buy, sell, and store both bitcoin and ether with superior trading features, security, and regulatory oversight.",
    pros: "Extremely quick response from customer support.#ACH deposits (up to $500/day) are immediately available for trading.#Reimburses $20 for wire transfer fee.",
    cons: "Limited currencies.", 
    deposit_withdrawal_limit: "ACH transfer have daily deposit limit of $500 & $10000 withdrawal limit. No limit for wire, BTC, ETH transfer.",
    fees: "0.25% base taker fee + 0.1% discount depending on 30 day trading volume. 0.25% base maker fee + discount schedule based on user's 30 day trading volume and buy/sell ratio.",
    cc_supported: false, 
    verification_required: true,
    rank: 1
  )


exchanges << gemini

cex = Exchange.new(
    name: "Cex",
    website: "https://cex.io/r/0/up105560109/0/",
    description: "CEX.IO offers cross-platform trading via website, mobile app, WebSocket and REST API, providing access to high liquidity orderbook for top currency pairs on the market. Instant Bitcoin buying and selling is available via simplified bundle interface.",
    pros: "0% maker fee.#Much cleaner UI compared to others.#Has generous refund policy.#Supports credit card purchase with the lowest fees.",
    cons: "Absence of insurance for hacked accounts.#No mention of what % of digital assets are in cold storage.#Does not support many US states.#Limited currencies.",
    deposit_withdrawal_limit: "$10,000 daily deposit & withdrawal limit for verified users",
    fees: "0% maker fee & 0.2% taker fee that goes down depending on the 30 day trade volume",
    cc_supported: true, 
    verification_required: false,
    rank: 3
)

exchanges << cex

shapeshift = Exchange.new(
    name: "Shapeshift",
    website: "https://shapeshift.io/?ref=coingenius.io",
    description: "The Safest, Fastest Asset Exchange on Earth. Trade any leading blockchain asset for any other. Protection by Design. No Account Needed",
    pros: "Instant currency exchange.#Intuitive UI.#Does not hold your money.",
    cons: "Unable to deposit using ACH transfer/bank wire",
    deposit_withdrawal_limit: "No limit",
    fees: "No exchange/service fees. Only miner fees", 
    cc_supported: false, 
    verification_required: false, 
    rank: 5
  )

exchanges << shapeshift

bitt.update(
  description: "At Bittrex.com, we take pride in supporting both new and established cryptocurrencies, providing you with an ever-growing selection of trading and investing opportunities. We conduct compliance audits on all new coin launches, ensuring that our users have the information they need to make informed trades.",
  pros: "Has 190+ coins in the market.#Moderately timely response from customer support.#Quick turnaround for identity verification",
  cons: "Absence of insurance for hacked accounts.#Confusing UX.#Unable to deposit using ACH transfer/bank wire",
  deposit_withdrawal_limit: "100 BTC withdrawal limit for enhanced accounts",
  fees: "0.25% for each trade", 
  cc_supported: false, 
  verification_required: true, 
  rank: 4
)

exchanges << bitt
polo.update({
  description: "US-based digital asset exchange offering maximum security and advanced trading features.",
  pros: "Has majority of altcoins in the market.#Majority of coins are in cold-storage.",
  cons: "Does not support some US states.#Known for terrible customer support.#Withdrawing is getting increasingly difficult.#Unable to deposit using ACH transfer/bank wire.",
  deposit_withdrawal_limit: "$25,000 limit after verification",
  fees: "Starts at 0.15% taker fee & 0.25% maker fee and the rates go down depending on the trading volume",
  cc_supported: false, 
  verification_required: false, 
  rank: 8
})

exchanges << polo
kraken = Exchange.new(
    name: "Kraken",
    website: "https://www.kraken.com/?ref=coingenius.io",
    description: "Kraken is the largest Bitcoin exchange in euro volume and liquidity and also trading Canadian dollars, US dollars, British pounds and Japanese yen.",
    pros: "Moderately timely response from customer support.#Large Euro trading volume.#Good reputation approved by the German bank.",
    cons: "Too many steps to place an order.#Absence of insurance for hacked accounts",
    deposit_withdrawal_limit: "$25,000 daily deposit & withdrawal limit after verifying",
    fees: "Depends on the currency pairs, but generally starts at 0.16% maker fee & 0.26% taker fee",
    cc_supported: false,
    verification_required: true, 
    rank: 6
  )

exchanges << kraken

liqui = Exchange.new(
    name: "Liqui",
    website: "https://liqui.io/?ref=coingenius.io",
    description: "Digital Asset Exchange",
    pros: "No withdrawl & deposit limit.#Has many altcoins in the market.#Offers IOU trading for ico tokens.#Quick response from Customer Support.",
    cons: "Some customer have complained about the difficulty with withdrawing#Absence of insurance for hacked accounts.#Instructions on the site is lacking.",
    deposit_withdrawal_limit: "No limit",
    fees: "0.1% maker fee & 0.25% taker fee",
    cc_supported: false, 
    verification_required: false, 
    rank: 10
)

exchanges << liqui

bitfinex = Exchange.new(
    name: "Bitfinex",
    website: "https://www.bitfinex.com/?ref=coingenius.io",
    description: "Bitfinex offers the most liquid exchange in the world, allowing users to easily exchange Bitcoin, Ethereum, Ethereum Classic, Zcash, Monero, Litecoin, Dash, Iota, and Ripple against USD or BTC with minimal slippage.",
    pros: "Only exchange that doesn't require verification to make deposit & withdrawal.#Decent alternative to gdax&coinbase for eth btc purchase.#99.5% of coins are stored in cold storage#.Decent FAQ site.",
    cons: "Limited tradeable currencies.#User accounts have been hacked in the past.#Absence of insurance for hacked accounts.",
    deposit_withdrawal_limit: "No limit",
    fees: "Depends on the trade volume, starts at 0.1% taker fee & 0.2% maker fee",
    cc_supported: false,
    verification_required: false,
    rank: 12
  )

exchanges << bitfinex

hitbtc = Exchange.new(
    name: "Hitbtc",
    website: "https://hitbtc.com/?ref=coingenius.io",
    description: "HitBTC is aimed to become a global platform for companies dealing with virtual currencies, providing most advance exchange and clearing technologies.",
    pros: "Has many IOUs for recent icos",
    cons: "Absence of insurance for hacked accounts.#Unable to deposit using ACH transfer/bank wire.",
    deposit_withdrawal_limit: "$10,000 limit for both daily deposit & withdrawal for qualified accounts",
    fees: "0.1% maker fee & 0.01% rebate",
    cc_supported: false,
    verification_required: true,
    rank: 7
  )

exchanges << hitbtc

korbit = Exchange.new(
    name: "Korbit",
    website: "https://www.korbit.co.kr/?ref=coingenius.io",
    description: "The world's first Bitcoin-Korean Won exchange, built with cutting-edge technology and a customer-centric approach.",
    pros: "Korea's largest crypto exchange.#Good remittance program",
    cons: "Only people who have korean cellphones can verify.#Absence of insurance for hacked accounts.",
    deposit_withdrawal_limit: "Unlimited deposit & max of 40BTC withdrawal limit",
    fees: "Depends on the trade volume, starts at 0.100% taker fee & 0.200% maker fee",
    cc_supported: false,
    verification_required: true,
    rank: 11
  )
exchanges << korbit

wavesDEX = Exchange.new(
    name: "Waves DEX",
    website: "https://wavesplatform.com/?ref=coingenius.io",
    description: "DEX allows users to trade their tokens — including WAVES, BTC and any other assets issued on the Waves platform — completely trustlessly and without having to move their funds to a centralised exchange",
    pros: "Decentralized Exchange",
    cons: "Limited currencies.#Unable to deposit using ACH transfer/bank wire.",
    deposit_withdrawal_limit: "No limit",
    fees: "Standard Network fees much lower than 0.2%",
    cc_supported: false,
    verification_required: false, 
    rank: 9
  )
exchanges << wavesDEX
bitsharesDEX = Exchange.new(
    name: "Bitshares DEX",
    website: "https://bitshares.org/?ref=coingenius.io",
    description: "BitShares provides a high-performance decentralized exchange, with all the features you would expect in a trading platform. It can handle the trading volume of the NASDAQ, while settling orders the second you submit them. ",
    pros: "Cheapest fees.#Decentralized exchange.#No Limits.#IOUs & fiat currencies are tradeable.#Reserves are available for emergencies.",
    cons: "Unable to deposit using ACH transfer/bank wire",
    deposit_withdrawal_limit: "No limit",
    fees: "Few cents per trade",
    cc_supported: false,
    verification_required: false,
    rank: 2
  )
exchanges << bitsharesDEX
supernetDEX = Exchange.new(
    name: "Supernet EasyDEX",
    website: "https://supernet.org/?ref=coingenius.io",
    description: "A decentralized exchange that not only allows users to exchange cryptocurrencies among themselves without entrusting their funds to a third party but also a system that provides speed and liquidity",
    pros: "Decentralized Exchange",
    cons: "Limited currencies.#Still in beta.#Unable to deposit using ACH transfer/bank wire.",
    deposit_withdrawal_limit: "No limit",
    fees: "approximately 0.001%",
    cc_supported: false,
    verification_required: false, 
    rank: 10
  )
exchanges << supernetDEX
gdax = Exchange.new(
    name: "Gdax",
    website: "https://www.gdax.com/?ref=coingenius.io",
    description: "GDAX offers institutions and professionals the ability to trade a variety of digital currencies like Bitcoin, Ethereum, and more on a regulated U.S. based exchange.",
    pros: "0% maker fee.#FDIC-insured.#98% of digital assets are stored in cold storage.#Easy to use interface.",
    cons: "Unresponsive Customer Support. (Avg response time varies highly).#Verification process has been taking weeks lately.#Limited currencies.",
    deposit_withdrawal_limit: "$10,000 daily deposit & withdrawal limit for verified users",
    fees: "0% maker fee & taker fee starts at 0.3% and goes down depending on the 30 day trade volume",
    cc_supported: false,
    verification_required: true, 
    rank: 4
  )
exchanges << gdax
btc = Coin.new(
  name: "Bitcoin", 
  symbol: "BTC", 
  description: "Bitcoin is a cryptocurrency and a digital payment system", 
  website: "https://bitcoin.org/en/", 
  pros: "First cryptocurrency built on blockchain.#Most widely used cryptocurrency#Largest developer community.", 
  cons: "Slow transaction time.#Not segwit-ready.", 
  consensus_mechanism: "Proof of work", 
  category: "Currency", 
  image_url: "https://www.cryptocompare.com/media/19633/btc.png")
btc.exchanges << coinbase
coins << btc 

eth = Coin.new(
  name: "Ethereum", 
  symbol: "ETH", 
  description: "Ethereum is a decentralized platform that runs smart contracts: applications that run exactly as programmed without any possibility of downtime, censorship, fraud or third party interference.", 
  website: "https://www.ethereum.org/", 
  pros: "Programmable money.#Smart contracts.#Huge community - Ethereum Enterprise Alliance consists of companies like Microsoft, Intel, and more.", 
  cons: "Higher inflation than bitcoin.#More transactions per second than bitcoin but less than NEM.", 
  consensus_mechanism: "Proof of work", 
  category: "Currency", 
  image_url: "https://www.cryptocompare.com/media/20646/eth.png")
eth.exchanges << coinbase
coins << eth 

xrp = Coin.new(
  name: "Ripple", 
  symbol: "XRP", 
  description: "Ripple is a real-time gross settlement system (RTGS), currency exchange and remittance network operated by Ripple.", 
  website: "https://ripple.com/", 
  pros: "Open payment network with real-time gross settlement system.#Math-based currency.#Free from DoS attacks.#Its settlement infrastructure is used by the banks.",
  cons:"Founders of Ripple control over 99% of XRP.", 
  consensus_mechanism: "Ripple Protocol consensus algorithm", 
  category: "Platform", 
  image_url: "https://www.cryptocompare.com/media/19972/ripple.png")
xrp.exchanges << polo 
xrp.exchanges << bitt
coins << xrp

xem = Coin.new(
  name: "NEM", 
  symbol: "XEM", 
  description: "NEM has a stated goal of a wide distribution model and has introduced new features to blockchain technology such as its proof-of-importance (POI) algorithm, multisignature accounts, encrypted messaging, and an Eigentrust++ reputation system.",
  website: "https://www.nem.io/", 
  pros: "P2P platform that provides payment, messaging and more.#Can send payments and messages securely globally.#Incredibly scalable - 3000 transactions/sec/.#Low transaction fee - 0.01% fee.", 
  cons:"No private transactions.#No mining available.",
  consensus_mechanism: "Proof of importance", 
  category: "Payment Network",
  image_url: "https://www.cryptocompare.com/media/20490/xem.png")
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
  category: "currency", 
  image_url: "https://www.cryptocompare.com/media/19782/litecoin-logo.png")
ltc.exchanges << coinbase
coins << ltc 

etc = Coin.new(
  name: "Ethereum Classic", 
  symbol: "ETC", 
  description: "Ethereum Classic is a decentralized platform that runs smart contracts: applications that run exactly as programmed without any possibility of downtime, censorship, fraud or third party interference.", website: "https://ethereumclassic.github.io/",
  website: "https://ethereumclassic.github.io/",
  pros: "Continuation of the original Ethereum blockchain - the classic version preserving untampered history.#Cryptonote-based.", 
  cons: "Toxic community of developers who are against Ethereum.",
  consensus_mechanism: "CryptoNight proof of work", 
  category: "Currency", 
  image_url: "https://www.cryptocompare.com/media/20275/etc2.png")
etc.exchanges << bitt
etc.exchanges << polo 
coins << etc

dash = Coin.new(
  name: "Dash", 
  symbol: "DASH", 
  description: "Dash (formerly known as Darkcoin and XCoin) is an open source peer-to-peer cryptocurrency that offers instant transactions (InstantSend), private transactions (PrivateSend) and token fungibility.", 
  website: "https://www.dash.org/", 
  pros: "Instantaneous transaction time about 1.2 seconds.#Private transaction possible with privatesend.#Low transaction fee.", 
  cons: "Core team is secretive about their roadmaps.#Decentralized governance is immature - few masternode owners make the decision.",
  consensus_mechanism: "Proof of work", 
  category: "Payment Network", 
  image_url: "https://www.cryptocompare.com/media/20026/dash.png")
dash.exchanges << bitt 
dash.exchanges << polo 
coins << dash

xmr = Coin.new(
  name: "Monero", 
  symbol: "XMR", 
  description: "Monero (XMR) is a privacy-focused cryptocurrency that is not based on Bitcoin's code. Monero aims to be a fungible and untraceable digital medium of exchange.", website: "https://getmonero.org", 
  website: "https://getmonero.org",
  pros: "Unttraceable payments & Unlinkable transactions.#Wide adoption-second most used cryptocurrency in the dark web.#Cryptonote-based.",
  cons: "Untraceability makes it challenging to go mainstream.",
  consensus_mechanism: "CryptoNight proof of work", 
  category: "Currency", 
  image_url: "https://www.cryptocompare.com/media/19969/xmr.png")
xmr.exchanges << bitt
xmr.exchanges << polo 
coins << xmr

bcn = Coin.new(
  name: "Bytecoin", 
  symbol: "BCN", 
  description: "Bytecoin allows safe and secure transactions around the globe and offers the convenience of instant fee-free money transactions.", 
  website: "https://bytecoin.org/",
  pros: "Free instant international payments.#Unntraceable payment.#Cryptonote-based.",
  cons: "80%+ were premined prior to public release.",
  consensus_mechanism: "CryptoNight Proof of work", 
  category: "Payment Network", 
  image_url: "https://www.cryptocompare.com/media/20197/bytecoin-logo.png")
bcn.exchanges << bitt 
bcn.exchanges << polo 
coins << bcn

xlm = Coin.new(
  name: "Stellar Lumens", 
  symbol: "XLM", 
  description: "Stellar is a platform that connects banks, payments systems, and people.", 
  website: "https://www.stellar.org/", 
  pros: "Instant payment (2-5 seconds).#customizable payment infrastructure.",
  cons: "No mining available.#95% of Lumens were given out.",
  consensus_mechanism: "Stellar Consensus Protocol", 
  category: "Payment Network", 
  image_url: "https://www.cryptocompare.com/media/20696/str.png")
xlm.exchanges << bitt
xlm.exchanges << polo 
coins << xlm

doge = Coin.new(
  name: "Dogecoin", 
  symbol: "DOGE", 
  description: "Dogecoin is a cryptocurrency featuring a likeness of the Shiba Inu dog from the 'Doge' Internet meme as its logo.", 
  website: "http://dogecoin.com/", 
  pros: "Easy to send payments online.", 
  cons: "Coin is not taken seriously.#No unique technical feature.", 
  consensus_mechanism: "Proof of work", 
  category: "Currency",
  image_url: "https://www.cryptocompare.com/media/19684/doge.png")
doge.exchanges << bitt 
doge.exchanges << polo 
coins << doge

gnt = Coin.new(
  name: "Golem", 
  symbol: "GNT",
  description: "Golem is a global, open sourced, decentralized supercomputer that anyone can access. It's made up of the combined power of user's machines, from personal laptops to entire datacenters.", 
  website: "https://golem.network/", 
  pros: "It rewards you for renting out computing power.",
  cons: "No Mining available.",
  consensus_mechanism: "Unknown", 
  category: "Computing Power Network", 
  image_url: "https://coincap.io/images/coins/Golem.png")
gnt.exchanges << bitt 
gnt.exchanges << polo 
coins << gnt

rep = Coin.new(
  name: "Augur", 
  symbol: "REP", 
  description: "Augur is a fully open-source and decentralized prediction market platform built on Ethereum, a blockchain technology that allows for the execution of smart contracts.", 
  website: "https://augur.net/",
  pros: "It allows you to forecast events and be rewarded for predicting the outcome correctly.",
  cons: "Not much activity in the prediction market.",
  consensus_mechanism: "Proof of work", 
  category: "Prediction Market",
  image_url: "https://www.cryptocompare.com/media/350815/augur-logo.png")
rep.exchanges << bitt
rep.exchanges << polo 
coins << rep

zec = Coin.new(
  name: "Zcash", 
  symbol: "ZEC", 
  description: "Zcash is the first open, permissionless cryptocurrency that can fully protect the privacy of transactions using zero-knowledge cryptography.", 
  website: "https://z.cash/",
  pros: "Unttraceable payments & Unlinkable transactions.", 
  cons: "20% of block reward goes to the developers.",
  consensus_mechanism: "Proof of work", 
  category: "Currency",
  image_url: "https://www.cryptocompare.com/media/351360/zec.png")
zec.exchanges << bitt 
zec.exchanges << polo 
coins << zec

strat = Coin.new(
  name: "Stratis", 
  symbol: "STRAT", 
  description: "Stratis offers full service capabilities for the development, deployment and management of blockchain applications and solutions utilizing C# on the .Net framework.", 
  website: "https://stratisplatform.com/",
  pros: "Block chain as a service.(Private & public blockchains for corps)#Segwit-ready.#Master nodes provide extra services like making the network transactions more private, enabling instant transactions, etc.", 
  cons: "No customers as May 29th 2017.",
  consensus_mechanism: "Proof of stake", 
  category: "Platform",
  image_url: "https://www.cryptocompare.com/media/351303/stratis-logo.png")
strat.exchanges << bitt 
strat.exchanges << polo 
coins << strat

steem = Coin.new(
  name: "Steem", 
  symbol: "STEEM", 
  description: "Steem is a blockchain-based social media platform where anyone can earn rewards.",
  website: "https://steem.io/",
  pros: "Content creators on steemit.io get rewarded when their posts get upvoted.",
  cons: "Vulnerable to voting manipulation via sybil attack.",
  consensus_mechanism: "Proof of work", 
  category: "Currency",
  image_url: "https://www.cryptocompare.com/media/350907/steem.png")
steem.exchanges << bitt 
steem.exchanges << polo 
coins << steem

gno = Coin.new(
  name: "Gnosis", 
  symbol: "GNO", 
  description: "Based on Ethereum — The next generation blockchain network. Speculate on anything with an easy-to-use prediction market.", 
  website: "https://gnosis.pm/", 
  pros: "Can create customised prediction market app,",
  cons: "No known Gnosis-powered apps,",
  consensus_mechanism: "Unknown", 
  category: "Prediction Market",
  image_url: "https://www.cryptocompare.com/media/1383083/gnosis-logo.png")
gno.exchanges << bitt
gno.exchanges << polo 
coins << gno

waves = Coin.new(
  name: "Waves", 
  symbol: "WAVES", 
  description: "Crypto-platform for asset/custom token issuance, transfer and trading on blockchain",
  website: "https://wavesplatform.com/", 
  pros: "Allows for trading on its decentralized exchange.#Straightforward custom token creation process.#Fast transactions and future-proof scaling.#Friendly community.",
  cons: "Many fake coins created as a result of easy creation process.",
  consensus_mechanism: "Unknown", 
  category: "Platform",
  image_url: "https://www.cryptocompare.com/media/350884/waves_1.png")
waves.exchanges << bitt 
coins << waves

bts = Coin.new(
  name: "Bitshares", 
  symbol: "BTS", 
  description: "BitShares is a distributed multi-user database with update permissions managed by a defined set of rules and public key cryptography.",
  website: "https://bitshares.org/",
  pros: "Allows for trading on its decentralized exchange.#Extremely fast transaction time - handles tens of thousands/sec.#Allows for creation of smartcoins and user-issued assets akin to Waves' custom tokens.", 
  cons: "Declining developer interest.#Main developer left for Steem.",
  consensus_mechanism: "Delegated proof of stake", 
  category: "Platform", 
  image_url: "https://www.cryptocompare.com/media/20705/bts.png")
bts.exchanges << polo 
coins << bts

sia = Coin.new(
  name: "Siacoin", 
  symbol: "SC", 
  description: "Sia is a decentralized network of datacenters that, taken together, comprise the world's fastest, cheapest, and most secure cloud storage platform.",
  website: "http://sia.tech/",
  pros: "You get rewarded for renting out your computer storage.#Files are split across the network & encrypted so no need to worry about privacy.", 
  cons: "Low adoption due to people feeling uncomfortable renting out storage for storing illegal content.", 
  category: "Storage Network", 
  consensus_mechanism: "Proof of work", 
  image_url: "https://www.cryptocompare.com/media/20726/siacon-logo.png")
sia.exchanges << polo
sia.exchanges << bitt 
coins << sia
lykke = Coin.new(
  name: "Lykke", 
  symbol: "LKK", 
  description: "Next-generation trading platform with zero commission.", 
  website: "https://www.lykke.com/",
  pros: "You can trade colored coins that are associated with physical assets.#0 trading fees.#Each Lykke coin represents a share in the company.", 
  cons: "No mining available.#Coin is available only via their mobile app.#Not available in the US.",
  category: "Exchange", 
  consensus_mechanism: "N/A", 
  image_url: "https://www.cryptocompare.com/media/351734/lykke.png")
coins << lykke

coins.each do |coin| 
  if Coin.find_by_name(coin.name).nil?
    coin.save!
  else
    next 
  end
end

exchanges.each do |ex|
  if Exchange.find_by_name(ex.name).nil?
    ex.save!
  else
    next 
  end
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')