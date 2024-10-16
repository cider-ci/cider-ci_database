class ConsolidateGithubAuthtokensIntoDb < ActiveRecord::Migration[4.2]
  def change
    add_column :repositories, :foreign_api_endpoint, :text, null: false, default: ""
    add_column :repositories, :foreign_api_authtoken, :text, null: false, default: ""
    add_column :repositories, :foreign_api_owner, :text, null: false, default: ""
    add_column :repositories, :foreign_api_repo, :text, null: false, default: ""
    add_column :repositories, :foreign_api_type, :text, null: false, default: "github"

    reversible do |dir|
      dir.up do
        execute <<-SQL.strip_heredoc
          ALTER TABLE repositories ADD CONSTRAINT check_valid_foreign_api_type CHECK
            (foreign_api_type IN ('github'));
        SQL
      end
    end
    remove_column :repositories, :use_default_github_authtoken, :boolean, nil: false, default: false
    remove_column :repositories, :github_authtoken, :text
  end
end
