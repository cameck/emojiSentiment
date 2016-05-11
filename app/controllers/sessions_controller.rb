class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    #if the user and email are correct;
    if user && user.authenticate(params[:password])
      session[:user_id] = user_id
      redirect_to '/'
    else
    #if user log in credentials doesnt work, redirect to the login page
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
