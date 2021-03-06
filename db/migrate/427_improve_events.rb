require File.expand_path('../migration_helper.rb', __FILE__)

class ImproveEvents < ActiveRecord::Migration
  include MigrationHelper
  def change
    remove_column :repositories, :remote_http_fetch_token, :text
    add_or_replace_events_table "repositories"
    add_or_replace_events_table "users"
  end
end
