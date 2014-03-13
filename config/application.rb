require File.expand_path('../boot', __FILE__)

require 'rails/all'

unless Rails.env == 'production'
    require 'yaml' # is this needed?
    config = YAML.load_file("./config/env_vars.yml")
    if config.key?(Rails.env) && config[Rails.env].is_a?(Hash)
        config[Rails.env].each do |key,val|
            ENV[key] = val.to_s
        end
    end
end



# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Venturechallenge
  class Application < Rails::Application
    
    # Shopify API connection credentials:
    config.shopify.api_key = ENV['API_KEY']
    config.shopify.secret = ENV['SECRET']
    config.cache_store = :redis_store, 'redis://localhost:6379/0/cache', { expires_in: 90.minutes }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
