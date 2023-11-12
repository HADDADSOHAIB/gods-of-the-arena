# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_11_12_181020) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "fights", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
  end

  create_table "gladiator_fights", force: :cascade do |t|
    t.boolean "battle_won"
    t.integer "gladiator_id"
    t.integer "fight_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fight_id"], name: "index_gladiator_fights_on_fight_id"
    t.index ["gladiator_id", "fight_id"], name: "index_gladiator_fights_on_gladiator_id_and_fight_id", unique: true
    t.index ["gladiator_id"], name: "index_gladiator_fights_on_gladiator_id"
  end

  create_table "gladiators", force: :cascade do |t|
    t.string "name", null: false
    t.integer "life_points", default: 100, null: false
    t.integer "attack_points", default: 50, null: false
    t.integer "magic_points", default: 0, null: false
    t.integer "health_status", default: 0, null: false
    t.integer "age", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "experience_points", default: 0, null: false
  end

  create_table "shields", force: :cascade do |t|
    t.integer "protection_points", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tool_gladiator_fights", force: :cascade do |t|
    t.integer "tool_id", null: false
    t.integer "gladiator_id", null: false
    t.integer "fight_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fight_id"], name: "index_tool_gladiator_fights_on_fight_id"
    t.index ["gladiator_id", "fight_id", "tool_id"], name: "index_t_g_fs_on_g_id_and_f_id_and_t_id", unique: true
    t.index ["gladiator_id"], name: "index_tool_gladiator_fights_on_gladiator_id"
    t.index ["tool_id"], name: "index_tool_gladiator_fights_on_tool_id"
  end

  create_table "tools", force: :cascade do |t|
    t.string "name"
    t.string "toolable_type"
    t.integer "toolable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["toolable_type", "toolable_id"], name: "index_tools_on_toolable"
  end

  create_table "weapons", force: :cascade do |t|
    t.integer "attack_points", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "gladiator_fights", "fights", on_delete: :nullify
  add_foreign_key "gladiator_fights", "gladiators", on_delete: :nullify
  add_foreign_key "tool_gladiator_fights", "fights", on_delete: :nullify
  add_foreign_key "tool_gladiator_fights", "gladiators", on_delete: :nullify
  add_foreign_key "tool_gladiator_fights", "tools", on_delete: :nullify
end
