class User < ActiveRecord::Base
  has_many :saved_searches
  has_secure_password
end
