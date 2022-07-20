class User < ApplicationRecord
   devise :database_authenticatable, :registerable, :confirmable,
      :recoverable, :rememberable, :validatable, :trackable, :omniauthable

   has_many :tokens
   has_many :access_tokens, ->{ where(kind: :access) }, class_name: :Token
end
