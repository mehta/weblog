require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Weblog
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'UTC'

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    unless Rails.env.test?
      log_level              = String(ENV['LOG_LEVEL'] || "info").upcase
      config.logger          = Logger.new(STDOUT)
      config.logger.level    = Logger.const_get(log_level)
      config.log_level       = log_level
      config.lograge.enabled = true
      # config.lograge.formatter = Lograge::Formatters::Logstash.new
      # config.lograge.logger  = ActiveSupport::Logger.new "#{Rails.root}/log/lograge_#{Rails.env}.log"
      config.lograge.custom_options = lambda do |event|
        {:host => event.payload[:host], :agent => event.payload[:user_agent], :ip => event.payload[:ip]}
      end
    end

  end
end
