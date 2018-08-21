require File.expand_path('../boot', __FILE__)

require 'csv'
require 'rails/all'
require 'yaml'
# require 'wicked_pdf'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GoshadowV2
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.

    config.before_configuration do
      env_file = Rails.root.join('config', 'application.yml').to_s
      if File.exists?(env_file)
        YAML.load_file(env_file)[Rails.env].each do |key, value|
          ENV[key.to_s] = value
        end
      end
    end
    
    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths += %W(#{config.root}/modules)
    config.autoload_paths += %W(#{config.root}/app/models/assets)
    config.autoload_paths += %W(#{config.root}/app/models/references)
    config.autoload_paths += %W(#{config.root}/app/models/reports)
    config.autoload_paths += %W(#{config.root}/app/models/groups)

    # Prevents device from wrapping fields with errors in html, which breaks formatting: http://stackoverflow.com/questions/5267998/rails-3-field-with-errors-wrapper-changes-the-page-appearance-how-to-avoid-t
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      html_tag
    }

    # config.time_zone = "Eastern Time (US & Canada)"

  end
end