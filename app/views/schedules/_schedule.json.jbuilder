json.extract! schedule, :id, :title, :description, :start_time, :end_time, :start_date, :end_date, :created_at, :updated_at
json.url schedule_url(schedule, format: :json)
