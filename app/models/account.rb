class Account < ApplicationRecord
   belongs_to :social
   belongs_to :user
end
