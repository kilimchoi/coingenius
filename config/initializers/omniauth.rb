# We have to override hostname for OmniAuth on production environment
# because OmniAuth does not determine that it is an HTTPS server.
# It seems like CloudFlare or Heroku are involved in SSL termination
# procedure which means that Rails behaves like a normal HTTP backend in that case.
if Rails.env.production?
  OmniAuth.config.full_host = "https://coingenius.io"
end
