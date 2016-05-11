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
    search = client.search("##{input}", result_type: "recent").take(1000)

    tweets = []

    search.each do |search_item|

      text = search_item.text

      if text.include?("🍕")
        tweets << text
      end
    end

    return tweets

  end
end
