class AddColumnToSavedSearchItems < ActiveRecord::Migration
  def change
    add_column :saved_search_items, :sentiment_score, :decimal
  end
end
