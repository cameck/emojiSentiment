class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create      # add custom create logic here
  end

  def update
    super
  end

private
  def sign_up_params
    params.require(:user).permit(:name, :last_name, :company_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :last_name, :company_name, :email, :password, :password_confirmation, :current_password)
  end

end
