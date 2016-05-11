class TwitterBot < ActiveRecord::Base

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = ENV['TWITTER_TOKEN']
      config.access_token_secret = ENV['TWITTER_T_SECRET']
    end
  end

  def search(input)

    # GET Twitter hashtag search Results
    search = client.search("##{input}", result_type: "recent").take(1000)


    # Scan for Emojis & Save in Array
    tweets = []

    search.each_with_index do |search_item, index|
      text = search_item.text

      EmojiData.scan(text).each do |ec|
         tweets << ec.unified
      end
    end

    # count unique tweets
    tweet_counts = Hash.new 0
    tweets.each do |tweet|
      tweet_counts[tweet] += 1
    end

    # sort tweets
    sorted_tweets = tweet_counts.sort_by {|_key, value| value}
    sorted_tweets = sorted_tweets.last(3).reverse

  end
end
