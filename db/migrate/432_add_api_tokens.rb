require File.expand_path("../migration_helper.rb", __FILE__)

class AddApiTokens < ActiveRecord::Migration[4.2]
  include MigrationHelper

  def change
    create_table :api_tokens, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.string :token_hash, null: false, limit: 45
      t.string :token_part, null: false, limit: 5
      t.boolean :revoked, default: false, null: false
      t.boolean :scope_read, default: true, null: false
      t.boolean :scope_write, default: false, null: false
      t.boolean :scope_admin_read, default: false, null: false
      t.boolean :scope_admin_write, default: false, null: false
      t.text :description
    end

    add_index :api_tokens, :token_hash, unique: true

    add_auto_timestamps :api_tokens

    add_foreign_key :api_tokens, :users, on_delete: :cascade, on_update: :cascade

    add_column :api_tokens, :expires_at, "timestamp with time zone", null: false

    reversible do |dir|
      dir.up do
        execute <<-SQL

          ALTER TABLE api_tokens ADD CONSTRAINT sensible_scrope_write CHECK
          ( ( NOT scope_write ) OR ( scope_write AND scope_read ));

          ALTER TABLE api_tokens ADD CONSTRAINT sensible_scope_admin_read CHECK
          ( ( NOT scope_admin_read ) OR ( scope_admin_read AND scope_write AND scope_read ));

          ALTER TABLE api_tokens ADD CONSTRAINT sensible_scrope_admin_write CHECK
          ( ( NOT scope_admin_write ) OR ( scope_admin_write AND scope_admin_read ));

        SQL

        execute "ALTER TABLE api_tokens ALTER COLUMN expires_at SET DEFAULT now() + interval '1 year'"
      end
    end
  end
end
