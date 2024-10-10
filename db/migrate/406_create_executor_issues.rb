require File.expand_path('../migration_helper.rb', __FILE__)

class CreateExecutorIssues < ActiveRecord::Migration[4.2]
  include MigrationHelper

  def change
    create_table :executor_issues, id: :uuid do |t|
      t.text :title
      t.text :description
      t.string :type, null: false, default: 'error'
      t.uuid "executor_id", null: false
      t.index "executor_id"
    end

    add_auto_timestamps 'executor_issues'

    add_foreign_key :executor_issues, :executors,
      on_delete: :cascade

  end
end
