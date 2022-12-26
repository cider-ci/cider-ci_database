require File.expand_path('../migration_helper.rb', __FILE__)

class UdateJobStatsView < ActiveRecord::Migration[4.2]
  include MigrationHelper

  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL.strip_heredoc

          DROP VIEW IF EXISTS job_stats;
          CREATE OR REPLACE VIEW job_stats AS
            SELECT jobs.id as job_id,
             (select count(*) from tasks where tasks.job_id = jobs.id) as total,
        #{ config_default[:constants][:STATES][:JOB].map{|state|
        "(select count(*) from tasks where tasks.job_id = jobs.id and state = '" + state +"') AS " + state
        }.join(", ")}
            FROM jobs

        SQL

      end
    end
  end
end
