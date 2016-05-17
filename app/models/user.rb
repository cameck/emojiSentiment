class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :saved_searches
  has_many :saved_search_items, through: :saved_searches

  # before_action :authenticate_user! this is here for reference for when we need to use it.
end
