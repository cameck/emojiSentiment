class AddSavedSearchRefToSavedSearchItems < ActiveRecord::Migration
  def change
    add_reference :saved_search_items, :saved_search, index: true, foreign_key: true
  end
end
