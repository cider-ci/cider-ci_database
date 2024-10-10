class ConvertFetchInterallToDuration < ActiveRecord::Migration[4.2]
  def change
    remove_column :repositories, :git_fetch_and_update_interval
    add_column :repositories, :git_fetch_and_update_interval, :text, null: false, default: '1 Minute'
  end
end
