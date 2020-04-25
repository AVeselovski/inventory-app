json.extract! category, :id, :name, :position, :created_at, :updated_at, :items
json.url category_url(category, format: :json)
