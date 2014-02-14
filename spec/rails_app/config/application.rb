require File.expand_path('../boot', __FILE__)

require "rails/all"

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module RailsApp
  class Application < Rails::Application
    I18n.enforce_available_locales = false
  end
end
