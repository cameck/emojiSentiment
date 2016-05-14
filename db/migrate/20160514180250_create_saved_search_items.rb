class CreateSavedSearchItems < ActiveRecord::Migration
  def change
    create_table :saved_search_items do |t|

      t.timestamps null: false
    end
  end
end
