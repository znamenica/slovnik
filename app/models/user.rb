class User < ApplicationRecord
   rolify
   devise :database_authenticatable, :registerable, :confirmable,
      :recoverable, :rememberable, :validatable, :trackable, :omniauthable

   has_many :tokens
   has_many :access_tokens, ->{ where(kind: :access) }, class_name: :Token
   has_many :accounts
   has_many :names, as: :dictumable
   has_many :socials, ->{ distinct }, through: :accounts

   accepts_nested_attributes_for :names, reject_if: :all_blank, allow_destroy: true
   accepts_nested_attributes_for :accounts, reject_if: :all_blank, allow_destroy: true

   def email= value
      if value
         email = Social.first_or_create(uri: 'email://loc', kind: 'email')
         accounts.first_or_initialize(social: email, sid: value)
      end
   end

   def email
      @email ||= accounts.find {|a| a.social.kind == 'email' }&.sid
   end

   def will_save_change_to_email?
      accounts.any? {|a| !a.id }
   end
end
