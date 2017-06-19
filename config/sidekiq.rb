require 'sidekiq'
require 'sidekiq/scheduler'
require "sidekiq/web"

Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path("sidekiq.yml",__FILE__))
    puts 'schedule is ', Sidekiq.schedule
    Sidekiq::Scheduler.reload_schedule! # This will retrigger the loading stage 
  end
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL" }
end

