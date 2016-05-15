desc 'update sentiment graph'
task update_sentiment_graph: :production do
  # ... set options if any
  # UserMailer.digest_email_update(options).deliver!
  SavedSearch.update_graph
end
