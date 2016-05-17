desc 'update sentiment graph'
task update_sentiment_graph: :environment do

  SavedSearch.update_graph
end
