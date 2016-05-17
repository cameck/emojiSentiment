class UsersController < ApplicationController
  before_action :clean_params, only: [:show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @saved_searches = saved_searches
  end

  def save_search
    SavedSearch.create( search: params[:hash_tag], user_id: current_user.id )
    flash[:notice] = "#{params[:hash_tag]} successfully saved, check back in a few days as we aggregate some data you :)"
    render 'show'
  end

  def saved_searches
    SavedSearch.where(user_id: current_user.id)
  end

  private

  def clean_params
    params.permit(:hash_tag)
  end
end
