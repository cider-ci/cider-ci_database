class AddTriggerEventToJobs < ActiveRecord::Migration[4.2]
  def change
    add_column :jobs, :trigger_event, :jsonb
  end
end
