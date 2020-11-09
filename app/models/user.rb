class User < ApplicationRecord
   validates_presence_of :names
   validates_uniqueness_of :names
end
