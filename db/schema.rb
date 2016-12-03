# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"
  enable_extension "uuid-ossp"

  create_table "branch_update_events", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "branch_id",                               null: false
    t.string   "tree_id",    limit: 40,                   null: false
    t.datetime "created_at",            default: "now()", null: false
  end

  add_index "branch_update_events", ["created_at"], name: "index_branch_update_events_on_created_at", using: :btree

  create_table "branches", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "repository_id",                                  null: false
    t.string   "name",                                           null: false
    t.string   "current_commit_id", limit: 40,                   null: false
    t.datetime "created_at",                   default: "now()", null: false
    t.datetime "updated_at",                   default: "now()", null: false
  end

  add_index "branches", ["name"], name: "index_branches_on_name", using: :btree
  add_index "branches", ["repository_id", "name"], name: "index_branches_on_repository_id_and_name", unique: true, using: :btree

  create_table "branches_commits", primary_key: "branch_id", force: :cascade do |t|
    t.string "commit_id", limit: 40, null: false
  end

  create_table "commit_arcs", id: false, force: :cascade do |t|
    t.string "parent_id", limit: 40, null: false
    t.string "child_id",  limit: 40, null: false
  end

  add_index "commit_arcs", ["child_id", "parent_id"], name: "index_commit_arcs_on_child_id_and_parent_id", using: :btree
  add_index "commit_arcs", ["parent_id", "child_id"], name: "index_commit_arcs_on_parent_id_and_child_id", unique: true, using: :btree

  create_table "commits", force: :cascade do |t|
    t.string   "tree_id",         limit: 40
    t.integer  "depth"
    t.string   "author_name"
    t.string   "author_email"
    t.datetime "author_date"
    t.string   "committer_name"
    t.string   "committer_email"
    t.datetime "committer_date"
    t.text     "subject"
    t.text     "body"
    t.datetime "created_at",                 default: "now()", null: false
    t.datetime "updated_at",                 default: "now()", null: false
  end

  add_index "commits", ["author_date"], name: "index_commits_on_author_date", using: :btree
  add_index "commits", ["committer_date"], name: "index_commits_on_committer_date", using: :btree
  add_index "commits", ["depth"], name: "index_commits_on_depth", using: :btree
  add_index "commits", ["tree_id"], name: "index_commits_on_tree_id", using: :btree
  add_index "commits", ["updated_at"], name: "index_commits_on_updated_at", using: :btree

  create_table "email_addresses", primary_key: "email_address", force: :cascade do |t|
    t.uuid    "user_id"
    t.boolean "primary", default: false, null: false
  end

  add_index "email_addresses", ["user_id"], name: "index_email_addresses_on_user_id", using: :btree

  create_table "executor_issues", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "title"
    t.text     "description"
    t.string   "type",        default: "error", null: false
    t.uuid     "executor_id",                   null: false
    t.datetime "created_at",  default: "now()", null: false
    t.datetime "updated_at",  default: "now()", null: false
  end

  add_index "executor_issues", ["executor_id"], name: "index_executor_issues_on_executor_id", using: :btree

  create_table "executors", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",                                        null: false
    t.float    "max_load",                  default: 1.0,     null: false
    t.boolean  "enabled",                   default: true,    null: false
    t.string   "traits",                    default: [],                   array: true
    t.datetime "last_ping_at"
    t.datetime "created_at",                default: "now()", null: false
    t.datetime "updated_at",                default: "now()", null: false
    t.string   "accepted_repositories",     default: [],                   array: true
    t.boolean  "upload_tree_attachments",   default: true,    null: false
    t.boolean  "upload_trial_attachments",  default: true,    null: false
    t.text     "version"
    t.float    "temporary_overload_factor", default: 1.5,     null: false
  end

  add_index "executors", ["accepted_repositories"], name: "index_executors_on_accepted_repositories", using: :btree
  add_index "executors", ["name"], name: "index_executors_on_name", unique: true, using: :btree
  add_index "executors", ["traits"], name: "index_executors_on_traits", using: :btree

  create_table "job_issues", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "title"
    t.text     "description"
    t.string   "type",        default: "error", null: false
    t.uuid     "job_id",                        null: false
    t.datetime "created_at",  default: "now()", null: false
    t.datetime "updated_at",  default: "now()", null: false
  end

  add_index "job_issues", ["job_id"], name: "index_job_issues_on_job_id", using: :btree

  create_table "job_specifications", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.jsonb "data"
  end

  create_table "job_state_update_events", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "job_id"
    t.string   "state"
    t.datetime "created_at", default: "now()", null: false
  end

  add_index "job_state_update_events", ["created_at"], name: "index_job_state_update_events_on_created_at", using: :btree
  add_index "job_state_update_events", ["job_id"], name: "index_job_state_update_events_on_job_id", using: :btree

  create_table "jobs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "state",                           default: "pending", null: false
    t.text     "key",                                                 null: false
    t.text     "name",                                                null: false
    t.text     "description"
    t.jsonb    "result"
    t.string   "tree_id",              limit: 40,                     null: false
    t.uuid     "job_specification_id",                                null: false
    t.integer  "priority",                        default: 0,         null: false
    t.datetime "created_at",                      default: "now()",   null: false
    t.datetime "updated_at",                      default: "now()",   null: false
    t.uuid     "created_by"
    t.uuid     "aborted_by"
    t.datetime "aborted_at"
    t.uuid     "resumed_by"
    t.datetime "resumed_at"
  end

  add_index "jobs", ["job_specification_id"], name: "index_jobs_on_job_specification_id", using: :btree
  add_index "jobs", ["key"], name: "index_jobs_on_key", using: :btree
  add_index "jobs", ["name"], name: "index_jobs_on_name", using: :btree
  add_index "jobs", ["tree_id", "job_specification_id"], name: "idx_jobs_tree-id_job-specification-id", unique: true, using: :btree
  add_index "jobs", ["tree_id", "key"], name: "idx_jobs_tree-id_key", unique: true, using: :btree
  add_index "jobs", ["tree_id", "name"], name: "idx_jobs_tree-id_name", unique: true, using: :btree
  add_index "jobs", ["tree_id"], name: "index_jobs_on_tree_id", using: :btree

  create_table "pending_create_trials_evaluations", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "task_id",                                       null: false
    t.uuid     "trial_state_update_event_id"
    t.datetime "created_at",                  default: "now()", null: false
  end

  add_index "pending_create_trials_evaluations", ["created_at"], name: "index_pending_create_trials_evaluations_on_created_at", using: :btree
  add_index "pending_create_trials_evaluations", ["task_id"], name: "index_pending_create_trials_evaluations_on_task_id", using: :btree

  create_table "pending_job_evaluations", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "job_id",                                       null: false
    t.uuid     "task_state_update_event_id"
    t.datetime "created_at",                 default: "now()", null: false
  end

  add_index "pending_job_evaluations", ["created_at"], name: "index_pending_job_evaluations_on_created_at", using: :btree

  create_table "pending_result_propagations", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "trial_id",                     null: false
    t.datetime "created_at", default: "now()", null: false
  end

  add_index "pending_result_propagations", ["created_at"], name: "index_pending_result_propagations_on_created_at", using: :btree

  create_table "pending_task_evaluations", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "task_id",                                       null: false
    t.uuid     "trial_state_update_event_id"
    t.datetime "created_at",                  default: "now()", null: false
  end

  add_index "pending_task_evaluations", ["created_at"], name: "index_pending_task_evaluations_on_created_at", using: :btree

  create_table "repositories", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "git_url",                                                      null: false
    t.string   "name"
    t.boolean  "public_view_permission",        default: false
    t.datetime "created_at",                    default: "now()",              null: false
    t.datetime "updated_at",                    default: "now()",              null: false
    t.uuid     "update_notification_token",     default: "uuid_generate_v4()"
    t.uuid     "proxy_id",                      default: "uuid_generate_v4()", null: false
    t.text     "branch_trigger_include_match",  default: "^.*$",               null: false
    t.text     "branch_trigger_exclude_match",  default: "",                   null: false
    t.string   "remote_api_endpoint"
    t.string   "remote_api_token"
    t.string   "remote_api_namespace"
    t.string   "remote_api_name"
    t.text     "remote_api_type"
    t.text     "remote_fetch_interval",         default: "1 Minute",           null: false
    t.string   "remote_api_token_bearer"
    t.boolean  "send_status_notifications",     default: true,                 null: false
    t.boolean  "manage_remote_push_hooks",      default: false,                null: false
    t.text     "branch_trigger_max_commit_age", default: "12 hours"
  end

  add_index "repositories", ["created_at"], name: "index_repositories_on_created_at", using: :btree
  add_index "repositories", ["git_url"], name: "index_repositories_on_git_url", unique: true, using: :btree
  add_index "repositories", ["update_notification_token"], name: "index_repositories_on_update_notification_token", using: :btree
  add_index "repositories", ["updated_at"], name: "index_repositories_on_updated_at", using: :btree

  create_table "repository_events", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "repository_id"
    t.text     "event"
    t.datetime "created_at",    default: "now()", null: false
  end

  add_index "repository_events", ["repository_id"], name: "index_repository_events_on_repository_id", using: :btree

  create_table "script_state_update_events", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "script_id"
    t.string   "state"
    t.datetime "created_at", default: "now()", null: false
  end

  add_index "script_state_update_events", ["created_at"], name: "index_script_state_update_events_on_created_at", using: :btree
  add_index "script_state_update_events", ["script_id"], name: "index_script_state_update_events_on_script_id", using: :btree

  create_table "scripts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "trial_id",                                                            null: false
    t.string   "key",                                                                 null: false
    t.string   "state",                                           default: "pending", null: false
    t.string   "name",                                                                null: false
    t.string   "stdout",                         limit: 10485760, default: "",        null: false
    t.string   "stderr",                         limit: 10485760, default: "",        null: false
    t.string   "body",                           limit: 10240,    default: "",        null: false
    t.string   "timeout"
    t.string   "exclusive_executor_resource"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.jsonb    "start_when",                                      default: [],        null: false
    t.jsonb    "terminate_when",                                  default: [],        null: false
    t.jsonb    "environment_variables",                           default: {},        null: false
    t.boolean  "ignore_abort",                                    default: false,     null: false
    t.boolean  "ignore_state",                                    default: false,     null: false
    t.boolean  "template_environment_variables",                  default: false,     null: false
    t.datetime "created_at",                                      default: "now()",   null: false
    t.datetime "updated_at",                                      default: "now()",   null: false
    t.integer  "exit_status"
    t.jsonb    "command"
    t.string   "working_dir",                    limit: 2048
    t.string   "script_file",                    limit: 2048
    t.string   "wrapper_file",                   limit: 2048
    t.jsonb    "issues",                                          default: {},        null: false
  end

  add_index "scripts", ["issues"], name: "index_scripts_on_issues", using: :btree
  add_index "scripts", ["trial_id", "key"], name: "index_scripts_on_trial_id_and_key", unique: true, using: :btree

  create_table "submodules", primary_key: "path", force: :cascade do |t|
    t.string "submodule_commit_id", limit: 40, null: false
    t.string "commit_id",           limit: 40, null: false
  end

  add_index "submodules", ["commit_id"], name: "index_submodules_on_commit_id", using: :btree
  add_index "submodules", ["submodule_commit_id"], name: "index_submodules_on_submodule_commit_id", using: :btree

  create_table "task_specifications", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.jsonb "data"
  end

  create_table "task_state_update_events", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "task_id"
    t.string   "state"
    t.datetime "created_at", default: "now()", null: false
  end

  add_index "task_state_update_events", ["created_at"], name: "index_task_state_update_events_on_created_at", using: :btree
  add_index "task_state_update_events", ["task_id"], name: "index_task_state_update_events_on_task_id", using: :btree

  create_table "tasks", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "job_id",                                           null: false
    t.string   "state",                        default: "pending", null: false
    t.text     "name",                                             null: false
    t.jsonb    "result"
    t.uuid     "task_specification_id",                            null: false
    t.integer  "priority",                     default: 0,         null: false
    t.string   "traits",                       default: [],        null: false, array: true
    t.string   "exclusive_global_resources",   default: [],        null: false, array: true
    t.datetime "created_at",                   default: "now()",   null: false
    t.datetime "updated_at",                   default: "now()",   null: false
    t.jsonb    "entity_errors",                default: []
    t.integer  "dispatch_storm_delay_seconds", default: 1,         null: false
    t.float    "load",                         default: 1.0,       null: false
  end

  add_index "tasks", ["exclusive_global_resources"], name: "index_tasks_on_exclusive_global_resources", using: :btree
  add_index "tasks", ["job_id", "name"], name: "index_tasks_on_job_id_and_name", unique: true, using: :btree
  add_index "tasks", ["job_id"], name: "index_tasks_on_job_id", using: :btree
  add_index "tasks", ["task_specification_id"], name: "index_tasks_on_task_specification_id", using: :btree
  add_index "tasks", ["traits"], name: "index_tasks_on_traits", using: :btree

  create_table "tree_attachments", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "path",                             null: false
    t.text     "content_length"
    t.text     "content_type"
    t.datetime "created_at",     default: "now()", null: false
    t.datetime "updated_at",     default: "now()", null: false
    t.text     "tree_id",                          null: false
  end

  add_index "tree_attachments", ["tree_id", "path"], name: "index_tree_attachments_on_tree_id_and_path", unique: true, using: :btree
  add_index "tree_attachments", ["tree_id"], name: "index_tree_attachments_on_tree_id", using: :btree

  create_table "tree_id_notifications", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "tree_id",     limit: 40,                   null: false
    t.uuid     "branch_id"
    t.uuid     "job_id"
    t.text     "description"
    t.datetime "created_at",             default: "now()", null: false
    t.datetime "updated_at",             default: "now()", null: false
  end

  create_table "tree_issues", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "title"
    t.text     "description"
    t.string   "type",        default: "error", null: false
    t.text     "tree_id",                       null: false
    t.datetime "created_at",  default: "now()", null: false
    t.datetime "updated_at",  default: "now()", null: false
  end

  add_index "tree_issues", ["tree_id"], name: "index_tree_issues_on_tree_id", using: :btree

  create_table "trial_attachments", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "path",                             null: false
    t.text     "content_length"
    t.text     "content_type"
    t.datetime "created_at",     default: "now()", null: false
    t.datetime "updated_at",     default: "now()", null: false
    t.uuid     "trial_id",                         null: false
  end

  add_index "trial_attachments", ["trial_id", "path"], name: "index_trial_attachments_on_trial_id_and_path", unique: true, using: :btree
  add_index "trial_attachments", ["trial_id"], name: "index_trial_attachments_on_trial_id", using: :btree

  create_table "trial_issues", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "title"
    t.text     "description"
    t.string   "type",        default: "error", null: false
    t.uuid     "trial_id",                      null: false
    t.datetime "created_at",  default: "now()", null: false
    t.datetime "updated_at",  default: "now()", null: false
  end

  add_index "trial_issues", ["trial_id"], name: "index_trial_issues_on_trial_id", using: :btree

  create_table "trial_state_update_events", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "trial_id"
    t.string   "state"
    t.datetime "created_at", default: "now()", null: false
  end

  add_index "trial_state_update_events", ["created_at"], name: "index_trial_state_update_events_on_created_at", using: :btree
  add_index "trial_state_update_events", ["trial_id"], name: "index_trial_state_update_events_on_trial_id", using: :btree

  create_table "trials", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "task_id",                                      null: false
    t.uuid     "executor_id"
    t.text     "error"
    t.string   "state",         default: "pending",            null: false
    t.jsonb    "result"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at",    default: "now()",              null: false
    t.datetime "updated_at",    default: "now()",              null: false
    t.uuid     "created_by"
    t.uuid     "aborted_by"
    t.datetime "aborted_at"
    t.uuid     "token",         default: "uuid_generate_v4()", null: false
    t.datetime "dispatched_at"
  end

  add_index "trials", ["state"], name: "index_trials_on_state", using: :btree
  add_index "trials", ["task_id"], name: "index_trials_on_task_id", using: :btree

  create_table "user_events", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id"
    t.text     "event"
    t.datetime "created_at", default: "now()", null: false
  end

  add_index "user_events", ["user_id"], name: "index_user_events_on_user_id", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "password_digest"
    t.string   "login",                                       null: false
    t.boolean  "is_admin",                 default: false,    null: false
    t.datetime "created_at",               default: "now()",  null: false
    t.datetime "updated_at",               default: "now()",  null: false
    t.jsonb    "workspace_filters"
    t.boolean  "mini_profiler_is_enabled", default: false
    t.string   "reload_frequency"
    t.string   "ui_theme"
    t.string   "name"
    t.string   "github_access_token"
    t.integer  "github_id"
    t.boolean  "account_enabled",          default: true,     null: false
    t.boolean  "password_sign_in_allowed", default: true,     null: false
    t.string   "max_session_lifetime",     default: "7 days"
  end

  create_table "welcome_page_settings", force: :cascade do |t|
    t.text     "welcome_message"
    t.datetime "created_at",      default: "now()", null: false
    t.datetime "updated_at",      default: "now()", null: false
  end

  add_foreign_key "branch_update_events", "branches", on_delete: :cascade
  add_foreign_key "branches", "commits", column: "current_commit_id", on_delete: :cascade
  add_foreign_key "branches", "repositories", on_delete: :cascade
  add_foreign_key "branches_commits", "branches", on_delete: :cascade
  add_foreign_key "branches_commits", "commits", on_delete: :cascade
  add_foreign_key "commit_arcs", "commits", column: "child_id", on_delete: :cascade
  add_foreign_key "commit_arcs", "commits", column: "parent_id", on_delete: :cascade
  add_foreign_key "email_addresses", "users", on_delete: :cascade
  add_foreign_key "executor_issues", "executors", on_delete: :cascade
  add_foreign_key "job_issues", "jobs", name: "job_issues_jobs_fkey", on_delete: :cascade
  add_foreign_key "job_state_update_events", "jobs", on_delete: :cascade
  add_foreign_key "jobs", "job_specifications", name: "jobs_job-specifications_fkey"
  add_foreign_key "jobs", "users", column: "aborted_by"
  add_foreign_key "jobs", "users", column: "created_by"
  add_foreign_key "jobs", "users", column: "resumed_by"
  add_foreign_key "pending_create_trials_evaluations", "tasks", on_delete: :cascade
  add_foreign_key "pending_create_trials_evaluations", "trial_state_update_events", on_delete: :cascade
  add_foreign_key "pending_job_evaluations", "jobs", on_delete: :cascade
  add_foreign_key "pending_job_evaluations", "task_state_update_events", on_delete: :cascade
  add_foreign_key "pending_result_propagations", "trials", on_delete: :cascade
  add_foreign_key "pending_task_evaluations", "tasks", on_delete: :cascade
  add_foreign_key "pending_task_evaluations", "trial_state_update_events", on_delete: :cascade
  add_foreign_key "script_state_update_events", "scripts", on_delete: :cascade
  add_foreign_key "scripts", "trials", on_delete: :cascade
  add_foreign_key "submodules", "commits", on_delete: :cascade
  add_foreign_key "task_state_update_events", "tasks", on_delete: :cascade
  add_foreign_key "tasks", "jobs", name: "tasks_jobs_fkey", on_delete: :cascade
  add_foreign_key "trial_attachments", "trials", on_delete: :cascade
  add_foreign_key "trial_issues", "trials", name: "trial_issues_trials_fkey", on_delete: :cascade
  add_foreign_key "trial_state_update_events", "trials", on_delete: :cascade
  add_foreign_key "trials", "tasks", name: "trials_tasks_fkey", on_delete: :cascade
  add_foreign_key "trials", "users", column: "aborted_by"
  add_foreign_key "trials", "users", column: "created_by"
end
