#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require "mailman"

# require 'dotenv'
# Dotenv.load

# Mailman.config.logger = Logger.new("log/mailman.log")

# username = "#{ENV["EMAIL_CONFIRMATION_USERNAME"]}@#{ENV["EMAIL_CONFIRMATION_DOMAIN"]}"
username = "info@ahantu.com"

Mailman.config.pop3 = {
  server: 'pop.gmail.com',
  port: 995,
  ssl: true,
  username: username,
  password: "marviN!narcisio"
  # password: ENV["EMAIL_CONFIRMATION_PASSWORD"]
}

Mailman::Application.run do
  default do
    begin
      confirmation = EmailConfirmation.create(
        message: message.body.decoded,
        sender_id: EmailAddress.where(value: message.from.first).first_or_create.id,
        sender_type: "EmailAddress",
        recipient_id: EmailAddress.where(value: username).first_or_create.id,
        recipient_type: "EmailAddress",
        sent_at: Time.now,
      )
      case cart = Cart.all.reject { |cart| cart.confirmed? }.find { |cart| cart.receive_confirmation(confirmation) }
        when :confirmed
          #send confirmation email
        when :canceled
          #send cancelation email
          cart.send_email_cancelation
        when false
          #send unknow action email
      end

    rescue Exception => e
      Mailman.logger.error "Exception occurred while receiving message:\n#{message}"
      Mailman.logger.error [e, *e.backtrace].join("\n")
    end
  end
end
