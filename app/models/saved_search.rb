class SavedSearch < ActiveRecord::Base
  belongs_to :user
  has_many :saved_search_items

  def update_graph
    SavedSearch.all.each do |search|
      general_sentiment = TwitterBot.new
      tweets = general_sentiment.search(search.search)
      sentiments = general_sentiment.get_sentiment(tweets)
      average_sentiment = general_sentiment.calc_average_sentiment(tweets, sentiments)
      new_sentiment_item = SavedSearchItem.new(average_sentiment)
      new_sentiment_item.save
    end
  end
end
