class TwitterscannerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def process_request

    begin
      user_request = params[:twitterscanner]
      p "USER REQUEST: #{user_request}"
      user_name = user_request[:name]
      p "USER NAME: #{user_name}"
      user_tweet = user_request[:text]
      p "USER TWEET: #{user_tweet}"
      user_tweet = user_tweet.split
      hashtag = ""

      user_tweet.each do |t|
        if t.start_with?("#") && t != "#emojistats"
          hashtag = t
        end
      end
      p "HASH TAG: #{hashtag}"
      twitter_bot = TwitterBot.new()
      tweets = twitter_bot.search(hashtag)
      if tweets
        sentiments = twitter_bot.get_sentiment(tweets)
        tweet_at_user = "@#{user_name} Top 3 emojis & their associated sentiment #{tweets[0][0][0]}=#{sentiments[0]} #{tweets[1][0][0]}=#{sentiments[1]} #{tweets[2][0][0]}=#{sentiments[2]} | More info @ http://bit.ly/1qBqqJv (edited)"
        p "Tweet to send: #{tweet_at_user}"
        p twitter_bot.client.update(tweet_at_user)
      end
    # rescue
    #   render :nothing => true, :status => 500
    #   return
    end

    render :nothing => true, :status => :ok
  end

end
