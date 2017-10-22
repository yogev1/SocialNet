json.extract! event, :id, :organizer_id, :participant_id, :name, :location, :description, :date, :time, :category, :created_at, :updated_at
json.url event_url(event, format: :json)
