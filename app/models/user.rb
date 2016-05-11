class User < ActiveRecord::Base
  has_many :saved_searches
  has_secure_password

  def forgot_password
  @user = User.find_by_email(params[:email])
    random_password = Array.new(10).map { (65 + rand(58)).chr }.join
    @user.password = random_password
    @user.save!
    #Mailer goes here#
  end

  # def set_new_password
  #   @user = User.find_by_email(params[:email])
  #   new_password = @user.
  # end

end
