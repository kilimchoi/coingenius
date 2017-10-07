if Rails.env.in?(%w[staging production])
  ActionMailer::Base.smtp_settings = {
    address:   'smtp.mandrillapp.com',
    port:      587,
    user_name: ENV['MANDRILL_USERNAME'],
    password:  ENV['MANDRILL_API_KEY'],
    domain:    Rails.application.config.full_host
  }

  ActionMailer::Base.delivery_method = :smtp
end
