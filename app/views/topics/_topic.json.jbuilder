json.extract! topic, :id, :name, :description, :api_key, :created_at, :updated_at
json.url topic_url(topic, format: :json)
