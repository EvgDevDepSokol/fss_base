require File.expand_path('boot', __dir__)

require 'rails/all'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

TableList = YAML.load_file('public/data/tables.yml')

# ActiveSupport.halt_callback_chains_on_return_false = false

module FSS_database
  class Application < Rails::Application
    config.app_generators.stylesheet_engine :sass

    config.autoload_paths << "#{config.root}/lib"

    # config.web_console.whitelisted_ips = '10.0.226.8'

    # config.browserify_rails.commandline_options = ['--fast']
    config.browserify_rails.commandline_options =
      ['-t [ babelify --presets [ @babel/env @babel/react ] --plugins [ @babel/plugin-proposal-class-properties] --extensions .babel .js .jsx .es .es6 ]']
    # config.browserify_rails.commandline_options = ['-t [ babelify --presets [ env react ]]', '--extension jsx']
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.

    # config.active_record.use_pluralization = false
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ru
    # config.active_record.belongs_to_required_by_default = true
    # config.active_record.raise_in_transactional_callbacks = true
    # HEADS UP! i18n 1.1 changed fallbacks to exclude default locale.
    # But that may break your application.
    #
    # Please check your Rails app for 'config.i18n.fallbacks = true'.
    # If you're using I18n (>= 1.1.0) and Rails (< 5.2.2), this should be
    # 'config.i18n.fallbacks = [I18n.default_locale]'.
    # If not, fallbacks will be broken in your app by I18n 1.1.x.
    config.i18n.fallbacks = true
  end
end
