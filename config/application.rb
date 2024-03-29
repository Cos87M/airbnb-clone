require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AirbnbClone
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    # 20 Preventing sassc-rails from setting sass as the compressor
    config.assets.css_compressor = nil

    # Stripe key
    config.stripe.secret_key = ENV["STRIPE_SECRET_KEY"]
    config.stripe.publishable_key = ENV["STRIPE_PUBLISHABLE_KEY"]
    # the following line is to configure cookies
    # config.action_dispatch.cookies_same_site_protection = :none

    #  # Configure secure cookies for cross-site requests
    #  config.action_dispatch.cookies_same_site_protection = :none
    #  config.ssl_options = { hsts: { preload: true, max_age: 31536000, include_subdomains: true } }

    #  # Ensure cookies are only sent over HTTPS
    # config.force_ssl = true
    # config.session_store :cookie_store, key: '_airbnb_clone_session', secure: true, same_site: :none

  end
end
