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

ActiveRecord::Schema[7.0].define(version: 2022_08_01_224901) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "btree_gin"
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "attitude_kind", ["synonim", "antonim"]

  create_table "alphabeths", force: :cascade do |t|
    t.string "code", limit: 3, null: false, comment: "Three letter sized code of the alphabeth"
    t.jsonb "meta", default: {}, null: false, comment: "Jsoned metadata hash for the alphabeth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_alphabeths_on_code", unique: true
    t.index ["meta"], name: "index_alphabeths_on_meta"
  end

  create_table "attitudes", force: :cascade do |t|
    t.bigint "left_id", null: false, comment: "Left operand for the attitude"
    t.bigint "right_id", null: false, comment: "Right operand for the attitude"
    t.enum "kind", null: false, comment: "Attitude kind is one of Synonim, or Antonim", enum_type: "attitude_kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind"], name: "index_attitudes_on_kind"
    t.index ["left_id", "right_id", "kind"], name: "index_attitudes_on_left_id_and_right_id_and_kind", unique: true
    t.index ["left_id"], name: "index_attitudes_on_left_id"
    t.index ["right_id"], name: "index_attitudes_on_right_id"
  end

  create_table "dictionaries", force: :cascade do |t|
    t.string "uri", null: false, comment: "Base URI to the dictionary"
    t.jsonb "meta", default: {}, null: false, comment: "Jsoned metadata hash for the dictionary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meta"], name: "index_dictionaries_on_meta"
    t.index ["uri"], name: "index_dictionaries_on_uri", unique: true
  end

  create_table "grammars", force: :cascade do |t|
    t.bigint "language_id", null: false, comment: "Reference to the language"
    t.bigint "alphabeth_id", null: false, comment: "Reference to the alphabeth"
    t.bigint "dictionary_id", null: false, comment: "Reference to the dictionary record"
    t.jsonb "meta", default: {}, null: false, comment: "Jsoned metadata hash for the grammar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alphabeth_id"], name: "index_grammars_on_alphabeth_id"
    t.index ["dictionary_id"], name: "index_grammars_on_dictionary_id"
    t.index ["language_id", "alphabeth_id", "dictionary_id"], name: "index_grammars_on_language_alphabeth_dictionary", unique: true
    t.index ["language_id"], name: "index_grammars_on_language_id"
    t.index ["meta"], name: "index_grammars_on_meta"
  end

  create_table "languages", force: :cascade do |t|
    t.string "code", limit: 3, null: false, comment: "Three letter sized code of the language"
    t.jsonb "meta", default: {}, null: false, comment: "Jsoned metadata hash for the language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_languages_on_code", unique: true
    t.index ["meta"], name: "index_languages_on_meta"
  end

  create_table "libra", force: :cascade do |t|
    t.text "text", null: false, comment: "Буко"
    t.string "title", null: false, comment: "Надпис бука"
    t.string "type", null: false, comment: "Взор бука"
    t.bigint "author_id"
    t.tsvector "tsv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_libra_on_author_id"
    t.index ["text"], name: "index_libra_on_text"
    t.index ["title"], name: "index_libra_on_title"
    t.index ["tsv"], name: "index_libra_on_tsv", using: :gin
    t.index ["type"], name: "index_libra_on_type"
  end

  create_table "meanings", force: :cascade do |t|
    t.integer "tag_ids", default: [], null: false, array: true
    t.integer "article_ids", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tokens", force: :cascade do |t|
    t.string "code", null: false
    t.string "kind", null: false
    t.bigint "user_id", null: false
    t.datetime "expires_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_tokens_on_code", unique: true
    t.index ["expires_at"], name: "index_tokens_on_expires_at"
    t.index ["kind"], name: "index_tokens_on_kind"
    t.index ["user_id"], name: "index_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at", precision: nil
    t.string "firstname"
    t.string "midname"
    t.string "lastname"
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["firstname"], name: "index_users_on_firstname"
    t.index ["lastname"], name: "index_users_on_lastname"
    t.index ["midname"], name: "index_users_on_midname"
    t.index ["nickname"], name: "index_users_on_nickname"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attitudes", "meanings", column: "left_id", on_delete: :restrict
  add_foreign_key "attitudes", "meanings", column: "right_id", on_delete: :restrict
  add_foreign_key "grammars", "alphabeths", on_delete: :restrict
  add_foreign_key "grammars", "dictionaries", on_delete: :restrict
  add_foreign_key "grammars", "languages", on_delete: :restrict
  add_foreign_key "libra", "users", column: "author_id"
  add_foreign_key "tokens", "users"
end
