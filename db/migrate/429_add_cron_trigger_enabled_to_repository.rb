class AddCronTriggerEnabledToRepository < ActiveRecord::Migration[4.2]
  def change
    add_column :repositories, :cron_trigger_enabled, :boolean, default: false
  end
end
