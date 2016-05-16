class SavedSearchItem < ActiveRecord::Base
  belongs_to :saved_search

  def initialize(average_sentiment)
    sentiment_score = average_sentiment
  end
end
