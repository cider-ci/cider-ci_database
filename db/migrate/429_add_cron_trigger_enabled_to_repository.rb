class AddCronTriggerEnabledToRepository < ActiveRecord::Migration
  def change
    add_column :repositories, :cron_trigger_enabled, :boolean, default: false
  end
end
