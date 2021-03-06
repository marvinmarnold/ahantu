require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Ahantu
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pretoria'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en

    Date::DATE_FORMATS.merge!(default: '%d/%m/%Y')

    config.middleware.insert_before 0, "SearchSuggestions"

    config.assets.paths << Rails.root.join("app", "vendor", "assets", "images")

    ::SPREEDLY_ENVIRONMENT = Spreedly::Environment.new(ENV["SPREEDLY_ENVIRONMENT_KEY"], ENV["SPREEDLY_ACCESS_SECRET"])
    ::PAYMENT_GATEWAY_TOKEN = ENV["SPREEDLY_GATEWAY_TOKEN"]
  end
end