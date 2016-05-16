desc 'update sentiment graph'
task update_sentiment_graph: :production do

  SavedSearch.update_graph
end
