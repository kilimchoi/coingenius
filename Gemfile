source "https://rubygems.org"

ruby "2.3.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 5.1"
# Use sqlite3 as the database for Active Record
gem "pg"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem "therubyracer", platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem "turbolinks"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.0"
# bundle exec rake doc:rails generates the API under doc/api.
gem "activeadmin", github: "activeadmin"
gem "attr_encrypted", "~> 3.0" # Encrypt sensitive data
gem "awesome_print"
gem "bootstrap", "~> 4.0.0.alpha6"
gem "bugsnag"
gem "decent_exposure", "3.0.0"
gem "devise"
gem "dotenv-rails", groups: %i[development test]
gem "friendly_id", "~> 5.1.0"
gem "httparty"
gem "interactor-rails"
gem "mandrill-rails"
gem "mandrill_mailer"
gem "meta-tags"
gem "omniauth-coinbase", git: "https://github.com/kilimchoi/omniauth-coinbase.git"
gem "puma", "~> 3.10"
gem "rails-jquery-autocomplete"
gem "redis", "~>3.2"
gem "rinku"
gem "scenic"
gem "sdoc", "~> 0.4.0", group: :doc
gem "select2-rails"
gem "sidecloq"
gem "sidekiq", "~>4.0.1"
gem "sinatra", "~> 2.0"
gem "slim"
gem "uuid", require: false # For UUID validation

source "https://rails-assets.org" do
  gem "rails-assets-tether", ">= 1.1.0"
end

group :production do
  gem "rails_12factor"
end

group :development, :test do
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
  gem "sqlite3"
end

group :test do
  gem "database_cleaner"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
end
