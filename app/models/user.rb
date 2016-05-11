class User < ActiveRecord::Base
  has_many :saved_searches
end
