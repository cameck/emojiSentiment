class TwitterscannerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def process_request

    begin
      user_request = params[:twitterscanner]
      user_name = user_request[:name]
      user_tweet = user_request[:text]
      user_tweet = user_tweet.split
      hashtag = ""

      user_tweet.each do |t|
        if t.start_with?("#") && t != "#emojistats"
          hashtag = t
        end
      end

      twitter_bot = TwitterBot.new()
      tweets = twitter_bot.search(hashtag)
      if tweets
        sentiments = tweets.get_sentiment(tweets)
      end
      tweet_at_user = "@#{user_name} Top 3 emojis & their associated sentiment #{tweets[0][0][0]}=#{sentiments[0]} #{tweets[1][0][0]}=#{sentiments[1]} #{tweets[2][0][0]}=#{sentiments[2]} | More info @ http://bit.ly/1qBqqJv (edited)"

      client.update(tweet_at_user)

    rescue
      render :nothing => true, :status => 500
      return
    end

    render :nothing => true, :status => :ok
  end

end
