def setup_bullet
  return unless Rails.env.development?
  return unless defined?(Bullet)

  Rails.application.config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.bugsnag = true
  end
end

setup_bullet
