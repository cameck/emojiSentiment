class AddDetailsToSentiments < ActiveRecord::Migration
  def change
    change_column :sentiments, :sentiment, :decimal, precision: 5, scale: 2
  end
end
