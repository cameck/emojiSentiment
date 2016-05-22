require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EmojiSentiment
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
    config.action_mailer.smtp_settings = {
      address: "smtp.mailgun.org",
      port: 587,
      # domain: "gmail.com",
      user_name: "postmaster@mg.emojisentiment.com",
      password: "daf0483c1e2a26059c15ca51fac2624c",
      authentication: :plain,
      enable_starttls_auto: true
    }

    config.action_mailer.default_url_options = {
      host: "https://intense-coast-35405.herokuapp.com/"
    }
    config.action_mailer.delivery_method = :mailgun
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'configs.yml')

      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end
  end
end
