class TwitterBot < ActiveRecord::Base
  def client
    # Initialize Twitter Authentication
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = ENV['TWITTER_TOKEN']
      config.access_token_secret = ENV['TWITTER_T_SECRET']
    end
  end

  def search(input)
    # GET Twitter hashtag search Results
    input = URI.encode(input)
    search = client.search("##{input}", result_type: 'recent').take(1000)
    emoji_scan(search)
  rescue
    false
  end

  def emoji_scan(search)
    # Scan for Emojis & Save in Array
    tweets = []

    search.each do |search_item|
      text = search_item.text

      EmojiData.scan(text).each do |ec|
        # Save Emoji, Emoji name and Emoji Unicode in Array
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
    sorted_tweets = tweet_counts.sort_by { |_key, value| value }
    sorted_tweets.last(3).reverse
  end

  def get_sentiment(tweets)
    # analyze sentiment
    sentiments = []
    tweets.each do |tweet|
      emoji_sentiment = Sentiment.find_by(emoji: tweet)
      sentiments << format('%.2f', emoji_sentiment.sentiment) if emoji_sentiment
    end
    sentiments
  end

  def calc_average_sentiment(tweets, sentiments)
    total_sentiment = []
    total_events = 0
    tweets.zip(sentiments).each do |tweet, sentiment|
      total_sentiment << tweet[1] * sentiment.to_f
      total_events += tweet[1]
    end

    score = 0
    total_sentiment.each { |total| score += total }

    format('%.2f', score / total_occurences) if total_events && total_events > 0
  end

  def calc_total_aggregate_tweets(tweets)
    aggregate_tweet_number = 0
    tweets.each do |tweet|
      aggregate_tweet_number += tweet[1]
    end
    aggregate_tweet_number
  end

  def get_emoji_name(emojis)
    unpacked_emojis = unpack_emojis(emojis)

    emoji_names = []
    EmojiData.scan(unpacked_emojis).each do |ec|
      emoji_names << ec.name
    end
    correct_capitalization(emoji_names)
  end

  def correct_capitalization(emoji_names)
    emoji_capital_names = []
    emoji_names.each do |emoji_name|
      emoji_capital_names << emoji_name.split.map(&:capitalize).join(' ')
    end
    emoji_capital_names
  end

  def get_unicodes(emojis)
    unpacked_emojis = unpack_emojis(emojis)

    emoji_unicodes = []
    EmojiData.scan(unpacked_emojis).each do |ec|
      emoji_unicodes << ec.unified
    end
    emoji_unicodes
  end

  def unpack_emojis(emojis)
    unpacked_emojis = []
    emojis.each do |emoji|
      unpacked_emojis << emoji[0][0]
    end
    unpacked_emojis = unpacked_emojis.join
  end

  def filter_params(params)
    # For when users send tweet to receive a tweet back
    # (Request sent from TwitterScannerController)
    p "User Request=#{user_request = params}"
    user_name = user_request[:name]
    user_tweet = user_request[:text]

    user_tweet = user_tweet.split
    hashtag = []

    user_tweet.each do |tweet|
      if tweet.start_with?('#') && !tweet.casecmp('#emojisentiment')
        hashtag << tweet
      end
    end
    # Easter Egg for Silly Users
    hashtag[0] = 'silly' if !hashtag[0] || hashtag[0] == '#'
    filtered_params = { hashtag: hashtag[0], user_name: user_name }
    p "Filtered Params Result: #{filtered_params}"
    filtered_params
  end
end
