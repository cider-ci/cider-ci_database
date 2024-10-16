require File.expand_path("../migration_helper.rb", __FILE__)

class AddExecutorTokenAndEvents < ActiveRecord::Migration[4.2]
  include MigrationHelper

  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL.strip_heredoc
          DROP VIEW IF EXISTS executors_with_load;
          DROP VIEW IF EXISTS executors_load;
        SQL
      end
    end
    remove_column :executors, :last_ping_at, :timestamp

    add_column :executors, :token_hash, :text, limit: 45
    add_column :executors, :token_part, :text, limit: 5
    add_column :executors, :description, :text

    add_index :executors, :token_hash, unique: true
    add_or_replace_events_table :executors

    reversible do |dir|
      dir.up do
        execute <<-SQL.strip_heredoc
          CREATE OR REPLACE VIEW executors_load AS
            SELECT count(trials.id) AS trials_count,
              sum(COALESCE(tasks.load, 0.0)) AS current_load,
              executors.id AS executor_id
              FROM executors
              LEFT OUTER JOIN trials ON trials.executor_id = executors.id
                AND trials.state IN ('aborting', 'dispatching', 'executing')
              LEFT OUTER JOIN tasks ON tasks.id = trials.task_id
              GROUP BY executors.id;
        SQL

        execute <<-SQL.strip_heredoc
          CREATE OR REPLACE VIEW executors_with_load AS
            SELECT executors.*, executors_load.*,
              executors_load.current_load/executors.max_load relative_load
            FROM executors
              JOIN executors_load ON executors_load.executor_id = executors.id
        SQL
      end

      dir.down do
        execute <<-SQL.strip_heredoc
          DROP VIEW executors_with_load;
          DROP VIEW executors_load;
        SQL
      end
    end
  end
end
