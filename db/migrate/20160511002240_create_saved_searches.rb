class CreateSavedSearches < ActiveRecord::Migration
  def change
    create_table :saved_searches do |t|
      t.string :search
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
