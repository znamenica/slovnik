# frozen_string_literal: true

class ChangeLibra < ActiveRecord::Migration[6.1]
   def change
      change_table :libra do |t|
         t.string :cover_uri, default: '', comment: "Линка на картинку для чланка"
         t.string :abstract, default: '', null: false, comment: "Кратке тезе чланка"
      end
   end
end
