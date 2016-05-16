class WelcomeController < ApplicationController
  before_action :clean_params, only: [:show]
  def index
    @users = User.all
  end

  def show
    @users = User.all
    @hash_tag = params[:hash_tag]
    tweets= TwitterBot.new()
    @tweets = tweets.search(@hash_tag)
    @total_aggregate_tweets = tweets.calc_total_aggregate_tweets(@tweets)
    @sentiments = tweets.get_sentiment(@tweets)
    @average_sentiment = tweets.calc_average_sentiment(@tweets, @sentiments)
  end

  private

  def clean_params
    params.permit(:hash_tag)
  end
end
