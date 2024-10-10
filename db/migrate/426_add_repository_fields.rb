class AddRepositoryFields < ActiveRecord::Migration[4.2]
  def change
    add_column :repositories, :send_status_notifications, :boolean, null: false, default: true
    add_column :repositories, :manage_remote_push_hooks, :boolean, null: false, default: false
  end
end
