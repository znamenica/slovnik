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

ActiveRecord::Schema[7.0].define(version: 2022_08_21_023200) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "btree_gin"
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "article_kind", ["regular", "saying", "interpretation", "idiom"]
  create_enum "attitude_kind", ["synonim", "antonim"]
  create_enum "tag_kind", ["language", "alphabeth", "dictionary", "grammar", "article", "meaning", "librum"]

  create_table "accounts", force: :cascade do |t|
    t.bigint "social_id", null: false, comment: "References to social"
    t.bigint "user_id", null: false, comment: "References to user"
    t.string "sid", null: false, comment: "User identifier in the specified social"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sid"], name: "index_accounts_on_sid"
    t.index ["social_id", "sid"], name: "index_accounts_on_social_id_and_sid", unique: true
    t.index ["social_id"], name: "index_accounts_on_social_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "alphabeths", force: :cascade do |t|
    t.string "code", limit: 3, null: false, comment: "Three letter sized code of the alphabeth"
    t.jsonb "meta", default: {}, null: false, comment: "Jsoned metadata hash for the alphabeth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "short", limit: 2, comment: "Two-letter alphabeth code"
    t.index ["code"], name: "index_alphabeths_on_code", unique: true
    t.index ["meta"], name: "index_alphabeths_on_meta"
  end

  create_table "articles", force: :cascade do |t|
    t.bigint "meaning_id", null: false, comment: "Reference to its meaning"
    t.bigint "grammar_id", null: false, comment: "Reference to the article grammar"
    t.bigint "token_ids", default: [], null: false, comment: "Reference array to a token list", array: true
    t.bigint "tag_ids", default: [], null: false, comment: "Reference array to a tag list", array: true
    t.string "separators", limit: 1, default: [], null: false, comment: "Separator array used in the article", array: true
    t.jsonb "meta", default: {}, null: false, comment: "Jsoned metadata hash for the article"
    t.enum "kind", default: "regular", null: false, comment: "Kind of the article are: Regular, Saying, Interpretation, or Idiom", enum_type: "article_kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grammar_id"], name: "index_articles_on_grammar_id"
    t.index ["kind"], name: "index_articles_on_kind"
    t.index ["meaning_id"], name: "index_articles_on_meaning_id"
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

  create_table "dicta", force: :cascade do |t|
    t.string "text", null: false, comment: "Text of the dictum"
    t.bigint "language_id", null: false, comment: "Reference to the language"
    t.bigint "alphabeth_id", null: false, comment: "Reference to the alphabeth"
    t.string "dictumable_type", null: false
    t.bigint "dictumable_id", null: false, comment: "Polymorphic reference to a describable object"
    t.string "type", null: false, comment: "Model type for the dictum"
    t.tsvector "tsv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind", comment: "Kind of the typed dictum"
    t.index ["alphabeth_id"], name: "index_dicta_on_alphabeth_id"
    t.index ["dictumable_type", "dictumable_id"], name: "index_dicta_on_dictumable"
    t.index ["language_id"], name: "index_dicta_on_language_id"
    t.index ["text", "language_id", "alphabeth_id", "dictumable_id", "dictumable_type", "type", "kind"], name: "index_unique_for_dictum", unique: true
    t.index ["text"], name: "index_dicta_on_text"
    t.index ["tsv"], name: "index_dicta_on_tsv", using: :gin
    t.index ["type"], name: "index_dicta_on_type"
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
    t.string "short", limit: 2, comment: "Two-letter language code"
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
    t.bigint "tag_ids", default: [], null: false, comment: "Набор озов мѣток яко линки", array: true
    t.string "cover_uri", default: "", comment: "Линка на картинку для чланка"
    t.string "abstract", default: "", null: false, comment: "Кратке тезе чланка"
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

  create_table "pieces", force: :cascade do |t|
    t.bigint "language_ids", default: [], null: false, comment: "Reference array to languages", array: true
    t.string "text", null: false, comment: "Text of the piece without a spaces"
    t.jsonb "meta", default: {}, null: false, comment: "Jsoned metadata hash for the piece"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_ids", "text"], name: "index_pieces_on_language_ids_and_text", unique: true
    t.index ["language_ids"], name: "index_pieces_on_language_ids"
    t.index ["meta"], name: "index_pieces_on_meta"
    t.index ["text"], name: "index_pieces_on_text"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "socials", force: :cascade do |t|
    t.string "uri", null: false, comment: "Base URI of the social"
    t.jsonb "meta", default: {}, null: false, comment: "Jsoned metadata"
    t.string "kind", null: false, comment: "One word kind of the social"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind"], name: "index_socials_on_kind", unique: true
    t.index ["meta"], name: "index_socials_on_meta"
    t.index ["uri"], name: "index_socials_on_uri"
  end

  create_table "tags", force: :cascade do |t|
    t.enum "kind", null: false, comment: "Tag kind is one of six kinds", enum_type: "tag_kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind"], name: "index_tags_on_kind"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "accounts", "socials"
  add_foreign_key "accounts", "users"
  add_foreign_key "articles", "grammars"
  add_foreign_key "articles", "meanings"
  add_foreign_key "attitudes", "meanings", column: "left_id", on_delete: :restrict
  add_foreign_key "attitudes", "meanings", column: "right_id", on_delete: :restrict
  add_foreign_key "dicta", "alphabeths"
  add_foreign_key "dicta", "languages"
  add_foreign_key "grammars", "alphabeths", on_delete: :restrict
  add_foreign_key "grammars", "dictionaries", on_delete: :restrict
  add_foreign_key "grammars", "languages", on_delete: :restrict
  add_foreign_key "libra", "users", column: "author_id"
  add_foreign_key "tokens", "users"
end
