require_relative 'boot'

require 'rails/all'
config.assets.precompile += Ckeditor.assets
config.assets.precompile += %w( ckeditor/* )
config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wetraining
  class Application < Rails::Application
  	config.time_zone = 'Jakarta'
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
