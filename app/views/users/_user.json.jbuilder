json.extract! user, :id, :full_name, :username, :photo, :cover_image, :created_at, :updated_at
json.url user_url(user, format: :json)
