require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Datafter
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.assets.paths << Rails.root.join("app", "assets")
    config.load_defaults 5.1
    config.assets.precompile += ['stripe.js']
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end

    config.exceptions_app = self.routes

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :fr

  end
end

module SeoRubyOnRails
  class Application < Rails::Application
    # Deflater
    # See also : https://robots.thoughtbot.com/content-compression-with-rack-deflater
    config.middleware.use Rack::Deflater
  end
end
