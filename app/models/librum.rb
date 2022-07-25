class Librum < ApplicationRecord
   belongs_to :author, class_name: "User"

   default_scope { where(type: 'Librum') }
end
