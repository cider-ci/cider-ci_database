class AddTriggerEventToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :trigger_event, :jsonb
  end
end
