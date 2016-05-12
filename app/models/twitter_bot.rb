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

    emoji_scan(search)
  end

  def emoji_scan(search)
    # Scan for Emojis & Save in Array
    tweets = []

    search.each do |search_item|
      text = search_item.text

      EmojiData.scan(text).each do |ec|
        tweets << ec.chars
      end
    end

    emoji_count(tweets)
  end

  def emoji_count(tweets)
    # count unique tweets
    tweet_counts = Hash.new 0

    tweets.each do |tweet|
      tweet_counts[tweet] += 1
    end

    top_three_emojis(tweet_counts)
  end

  def top_three_emojis(tweet_counts)
    # sort tweets to top 3 emojis
    sorted_tweets = tweet_counts.sort_by {|_key, value| value}
    sorted_tweets = sorted_tweets.last(3).reverse
  end
end
