require File.expand_path('../migration_helper.rb', __FILE__)

class FixAr < ActiveRecord::Migration[4.2]
  include MigrationHelper

  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL.strip_heredoc
          ALTER TABLE ar_internal_metadata ALTER COLUMN created_at SET DEFAULT now();
          ALTER TABLE ar_internal_metadata ALTER COLUMN updated_at SET DEFAULT now();
        SQL
      end
    end
  end

end
