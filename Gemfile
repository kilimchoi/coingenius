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
gem "sdoc", "~> 0.4.0", group: :doc
gem "slim"
gem "activeadmin", github: "activeadmin"
gem "bugsnag"
gem "friendly_id", "~> 5.1.0"
gem "dotenv-rails", :groups => [:development, :test]
gem "awesome_print"
gem "redis", "~>3.2"
gem "puma", "~> 3.10"
gem "meta-tags"
gem "rinku"
gem "sidekiq", "~>4.0.1"
gem "bootstrap", "~> 4.0.0.alpha6"
gem "devise"
gem "decent_exposure", "3.0.0"
gem "select2-rails"
gem "httparty"
gem "sidecloq"
gem "sinatra", "~> 2.0"
gem "rails-jquery-autocomplete"
gem "interactor-rails"
gem "omniauth-coinbase", git: "https://github.com/kilimchoi/omniauth-coinbase.git"
gem "uuid", require: false # For UUID validation
gem "attr_encrypted", "~> 3.0" # Encrypt sensitive data
gem "scenic"
gem "mandrill_mailer"

source "https://rails-assets.org" do
  gem "rails-assets-tether", ">= 1.1.0"
end
# Use ActiveModel has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Use Unicorn as the app server
# gem "unicorn"

# Use Capistrano for deployment
# gem "capistrano-rails", group: :development

group :production do
  gem "rails_12factor"
end

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug"
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "sqlite3"
  gem 'scout_apm' # Dev profiling
  gem "listen"
end
