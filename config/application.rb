require_relative "boot"

require "rails/all"
require "pry"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CiderCiDatabase
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.

    config.active_record.schema_format = :sql
    config.active_record.timestamped_migrations = false

    config.paths["config/initializers"] \
      << Rails.root.join("initializers")

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    # config.autoload_lib(ignore: %w(assets tasks))

    config.active_record.belongs_to_required_by_default = false

    config.log_level = if ENV["RAILS_LOG_LEVEL"].present?
      ENV["RAILS_LOG_LEVEL"]
    else
      :info
    end
  end
end
