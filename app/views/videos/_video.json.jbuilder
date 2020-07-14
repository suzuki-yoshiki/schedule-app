json.extract! video, :id, :body, :youtube_url, :created_at, :updated_at
json.url user_videos_url(video, format: :json)
