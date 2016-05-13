class CreateSentiments < ActiveRecord::Migration
  def change
    create_table :sentiments do |t|
      t.string :emoji
      t.decimal :sentiment

      t.timestamps null: false
    end
  end
end
