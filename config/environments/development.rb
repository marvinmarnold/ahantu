Ahantu::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  host_ip = '146.185.163.82'
  app_domain = 'ahantu.com'
  email_username = 'info@ahantu.com'
  email_password = 'marviN!narcisio'

  # paypal_login = ENV["paypal_login"]
  # paypal_password = ENV["paypal_password"]
  # paypal_signature = ENV["paypal_signature"]
  # domain = ENV["DOMAIN"],
  # user_name = "#{ENV["EMAIL_USERNAME"]}@#{ENV["DOMAIN"]}",
  # email_password = ENV["EMAIL_PASSWORD"]

  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :test
    paypal_login = 'marvin-facilitator_api1.ahantu.com'
    paypal_password = 'AfQB7xBEGHT0Dx5rx8yZPL6B_plt2u8cvzw6e_9cx8Hcm8ftFRKho-_OBzj1'
    paypal_signature = 'ENhs2hAGOuOykjmqVL00ht9KXaKbc9KpIbTLlKz1pzUhTt2fUOmFRUMTCXfh'
    paypal_options = {
      :login => paypal_login,
      :password => paypal_password,
      :signature => paypal_signature
    }
    ::STANDARD_GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(paypal_options)
    ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
  end

  config.action_mailer.default_url_options = { host: host_ip }
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: app_domain,
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: email_username,
    password: email_password
  }
end

