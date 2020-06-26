json.array!(@schedules) do |schedule|
  json.extract! schedule, :id, :title, :description   
  json.start schedule.start_date   
  json.end schedule.end_date   
  json.url user_schedules_url(schedule, format: :html) 
end
