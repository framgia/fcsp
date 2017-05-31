require_relative "boot"

require "rails/all"
require "roo"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fcsp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence
    # over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.paths << Rails.root.join("app", "assets", "videos")

    config.rack_mini_profiler_environments = %w(development)
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**",
      "*.{rb,yml}")]
    config.eager_load_paths << Rails.root.join("lib", "support")
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:en, :vi, :jp]
    config.i18n.load_path += Dir[Rails.root.join("config",
      "locales", "**", "*.{rb,yml}")]
    config.autoload_paths += Dir["#{config.root}/app/view_objects/**/"]

    config.to_prepare do
      Devise::SessionsController.layout "education/layouts/application"
    end

    config.time_zone = "Bangkok"
  end
end
