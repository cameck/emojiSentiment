class CreateTwitterBots < ActiveRecord::Migration
  def change
    create_table :twitter_bots do |t|
      t.string :client
      t.string :search

      t.timestamps null: false
    end
  end
end
