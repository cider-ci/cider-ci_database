class AddRepositoryBrachTriggerFilters < ActiveRecord::Migration[4.2]
  def change
    add_column :repositories, :branch_trigger_include_match, :text, null: false, default: "^.*$"
    add_column :repositories, :branch_trigger_exclude_match, :text, null: false, default: ""
  end
end
