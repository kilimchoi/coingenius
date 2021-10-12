source "https://rubygems.org"

ruby "2.3.1"

gem "pg"
gem "rails", "~> 5.1"

gem "activeadmin", github: "activeadmin"
gem "attr_encrypted", "~> 3.0" # Encrypt sensitive data
gem "binance" # Binance client
gem "bootstrap", "~> 4.0.0.alpha6"
gem "bugsnag"
gem "decent_exposure", "3.0.0"
gem "devise"
gem "dry-container"
gem "dry-matcher"
gem "httparty"
gem "interactor-rails"
gem "jbuilder", "~> 2.0"
gem "jquery-rails"
gem "mandrill-rails"
gem "mandrill_mailer"
gem "meta-tags"
gem "mini_racer", platforms: :ruby
gem "omniauth-coinbase", git: "https://github.com/kilimchoi/omniauth-coinbase.git"
gem "puma", "~> 5.5"
gem "rails-jquery-autocomplete"
gem "react_on_rails", "10.0.2"
gem "redis", "~> 3.2"
gem "sass-rails", "~> 5.0"
gem "scenic"
gem "sdoc", "~> 0.4.0", group: :doc
gem "select2-rails"
gem "shapeshift_ruby"
gem "sidecloq"
gem "sidekiq", github: "mperham/sidekiq" # We will use master until 5.1 released "~> 5.1"
gem "sinatra", "~> 2.0"
gem "slim"
gem "statesman" # State machine implementation
gem "uglifier", ">= 1.3.0"
gem "uuid", require: false # For UUID validation
gem "webpacker", "~> 3.0"

source "https://rails-assets.org" do
  gem "rails-assets-tether", ">= 1.1.0"
end

group :production do
  gem "rails_12factor"
end

group :development, :test do
  gem "awesome_print"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "ffaker"
  gem "pry-byebug"
  gem "pry-rails"
end

group :development do
  gem "bullet"
  gem "listen"
  gem "rubocop", require: false
  gem "rubocop-rspec"
  gem "scout_apm" # Dev profiling
  gem "spring"
end

group :test do
  gem "database_cleaner"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
end
