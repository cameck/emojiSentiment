class AddDetailsToSavedSearchItems < ActiveRecord::Migration
  def change
    change_column :saved_search_items, :sentiment_score, :decimal, precision: 5, scale: 2
  end
end
