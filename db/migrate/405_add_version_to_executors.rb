class AddVersionToExecutors < ActiveRecord::Migration[4.2]
  def change
    add_column :executors, :version, :text
  end
end
