class WelcomeController < ApplicationController
  before_action :clean_params, only: [:show]
  def index

  end

  def show
    hash_tag = params[:hash_tag]
    tweets= TwitterBot.new()
    @tweets = tweets.search(hash_tag)
    render 'index'
  end

  private

  def clean_params
    params.permit(:hash_tag)
  end
end
