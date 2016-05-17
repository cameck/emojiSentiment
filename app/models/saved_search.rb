class SavedSearch < ActiveRecord::Base
  belongs_to :user
  has_many :saved_search_items
  validates_uniqueness_of :search
  
  def self.update_graph
    SavedSearch.all.each do |search_item|
      general_sentiment = TwitterBot.new
      tweets = general_sentiment.search(search_item.search)
      sentiments = general_sentiment.get_sentiment(tweets)
      average_sentiment = general_sentiment.calc_average_sentiment(tweets, sentiments)
      SavedSearchItem.create(sentiment_score: average_sentiment, saved_search_id: search_item.id)
    end
  end
end
