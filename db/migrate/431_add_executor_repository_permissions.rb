class AddExecutorRepositoryPermissions < ActiveRecord::Migration
  def change

    add_column :repositories, :all_executors_permitted, :boolean, default: true, null: false

    create_table :repository_executor_permissions, id: :uuid do |t|
      t.column :executor_id, :uuid, null: false
      t.column :repository_id, :uuid, null: false
      t.column :execute, :boolean, default: true, null: false
    end

    add_foreign_key :repository_executor_permissions, :repositories, on_delete: :cascade, on_update: :cascade
    add_foreign_key :repository_executor_permissions, :executors, on_delete: :cascade, on_update: :cascade


    add_column :repositories, :all_users_permitted, :boolean, default: true, null: false

    create_table :repository_user_permissions, id: :uuid do |t|
      t.column :user_id, :uuid, null: false
      t.column :repository_id, :uuid, null: false
      t.column :execute, :boolean, default: true, null: false
      t.column :manage, :boolean, default: false, null: false
    end

    add_foreign_key :repository_user_permissions, :repositories, on_delete: :cascade, on_update: :cascade
    add_foreign_key :repository_user_permissions, :users, on_delete: :cascade, on_update: :cascade

  end
end
