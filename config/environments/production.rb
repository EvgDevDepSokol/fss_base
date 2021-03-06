# frozen_string_literal: true

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = true

  # Do not eager load code on boot.
  config.eager_load = true

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Don't care if the mailer can't send.
  # config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false
  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false
  config.assets.digest = true
  # config.assets.logger = false
  # config.logger = ActiveSupport::Logger.new(nil)

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true
  config.assets.unknown_asset_fallback = true
  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  # config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  # config.assets.prefix = "/assets_dev"
  config.serve_static_assets = false
  # for 'sassc-rails'
  config.sass.inline_source_maps = true
  # config.after_initialize do
  #  # Enable bullet in your application
  #  Bullet.enable = true
  #  Bullet.alert = true
  # end
  config.assets.js_compressor = :uglifier
  config.log_level = :info
end
