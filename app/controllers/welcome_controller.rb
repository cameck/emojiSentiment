class WelcomeController < ApplicationController
  before_action :clean_params, only: [:show]
  def index
  end

  def show
    @hash_tag = params[:hash_tag]
    # Check if User Included a hash tag in their search query & delete if necessary
    if @hash_tag[0] == "#"
      @hash_tag[0] = ''
    end
    # New Twitter Bot object to run through Emoji parsing algorithm
    tweets= TwitterBot.new()
    @tweets = tweets.search(@hash_tag)
    if @tweets # Check if Twitter Request was Successful
      @total_aggregate_tweets = tweets.calc_total_aggregate_tweets(@tweets)
      @sentiments = tweets.get_sentiment(@tweets)
      @average_sentiment = tweets.calc_average_sentiment(@tweets, @sentiments)
    end
  end

  private

  def clean_params
    params.permit(:hash_tag)
  end
end
