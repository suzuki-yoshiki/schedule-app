json.array!(@schedules) do |schedule|
  json.extract! schedule, :id, :title, :description, :user_id  
  json.start schedule.start_date   
  json.end schedule.end_date   
  json.url user_schedule_url(schedule, format: :html) 
end
