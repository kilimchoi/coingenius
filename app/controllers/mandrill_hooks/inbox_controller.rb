class MandrillHooks::InboxController < ApplicationController
  include Mandrill::Rails::WebHookProcessor

  # To completely ignore unhandled events (not even logging), uncomment this line
  # ignore_unhandled_events!

  # If you want unhandled events to raise a hard exception, uncomment this line
  # unhandled_events_raise_exceptions!

  # To enable authentication, uncomment this line and set your API key.
  # It is recommended you pull your API keys from environment settings,
  # or use some other means to avoid committing the API keys in your source code.
  # authenticate_with_mandrill_keys! 'YOUR_MANDRILL_WEBHOOK_KEY'

  def handle_inbound(_event_payload)
    head(:ok)
  end

  def handle_unsub(event_payload)
    EmailSubscriptions::UnsubscribeUser.call(event_payload.msg(%w[email tags]))
  end
end
