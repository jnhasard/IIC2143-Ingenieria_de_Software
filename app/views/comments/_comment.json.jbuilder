json.extract! comment, :id, :user_id, :publication_id, :body, :visits_count, :created_at, :updated_at
json.url comment_url(comment, format: :json)
