class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAILER_SENDER_ADDRESS")
  layout "mailer"
end
