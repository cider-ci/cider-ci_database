require File.expand_path("../migration_helper.rb", __FILE__)

class CreateRepositoryEvents < ActiveRecord::Migration[4.2]
  include MigrationHelper

  def change
    add_or_replace_events_table "repositories"
    add_or_replace_events_table "users"
  end
end
