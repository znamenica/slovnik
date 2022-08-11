# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
class CleanupUsers < ActiveRecord::Migration[7.0]
   def up
      add_column :dicta, :kind, :string, index: true, comment: "Kind of the typed dictum"
      add_column :languages, :short, :string, limit: 2, index: { unique: true }, comment: "Two-letter language code"
      add_column :alphabeths, :short, :string, limit: 2, index: { unique: true }, comment: "Two-letter alphabeth code"

      language = Language.first_or_create(code: "rus", short: "ru")
      alphabeth = Alphabeth.first_or_create(code: "RUS", short: "RU", meta: { range: ["а-я", "ё", "А-Я", "Ё"] })

      email = Social.first_or_create(uri: "email://loc", kind: "email")
      User.find_each do |user|
         user.accounts.first_or_create(social: email, sid: user.read_attribute(:email)) if user.read_attribute(:email).present?
         user.names.first_or_create(kind: "first_name", text: user.firstname, language:, alphabeth:) if user.firstname
         user.names.first_or_create(type: "patronymic", text: user.midname, language:, alphabeth:) if user.midname
         user.names.first_or_create(type: "last_name", text: user.lastname, language:, alphabeth:) if user.lastname
         user.names.first_or_create(type: "nick_name", text: user.nickname, language:, alphabeth:) if user.nickname
      end

      remove_column :users, :firstname, type: :string
      remove_column :users, :midname, type: :string
      remove_column :users, :lastname, type: :string
      remove_column :users, :nickname, type: :string
      # remove_column :users, :email, default: "", null: false, type: :string
   end

   def down
      add_column :users, :firstname, :string
      add_column :users, :midname, :string
      add_column :users, :lastname, :string
      add_column :users, :nickname, :string
      # add_column :users, :email, :string, default: "", null: false

      email = Social.where(kind: "email").first

      User.find_each do |user|
         attrs = {
            email: user.accounts.where(social_id: email.id).first.sid,
            firstname: user.names.where(type: "FirstName").first&.text,
            midname: user.names.where(type: "Patronymic").first&.text,
            lastname: user.names.where(type: "LastName").first&.text,
            nickname: user.names.where(type: "NickName").first&.text,
         }

         user.update!(attrs)
         user.confirm
      end

      remove_column :languages, :short
      remove_column :alphabeths, :short
      remove_column :dicta, :kind
   end
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
