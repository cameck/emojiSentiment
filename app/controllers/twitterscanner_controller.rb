class TwitterscannerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def process_request
    begin
      twitter_bot = TwitterBot.new()
      user_tweet_data = twitter_bot.filter_params(params[:twitterscanner])
      tweets = twitter_bot.search(user_tweet_data[:hashtag])

      if tweets
        sentiments = twitter_bot.get_sentiment(tweets)
        tweet_at_user = "@#{user_tweet_data[:user_name]} Top 3 emoji sentiment score for #{user_tweet_data[:hashtag]}: #{tweets[0][0][0]}=#{sentiments[0]} #{tweets[1][0][0]}=#{sentiments[1]} #{tweets[2][0][0]}=#{sentiments[2]} | Details @ http://bit.ly/1qBqqJv"

        twitter_bot.client.update(tweet_at_user)
      end

    rescue
      render :nothing => true, :status => 500
      return
    end
    render :nothing => true, :status => :ok
  end

end
