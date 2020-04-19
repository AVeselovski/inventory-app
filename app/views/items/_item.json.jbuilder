json.extract! item, :id, :category_id, :name, :position, :quantity, :created_at, :updated_at
json.url item_url(item, format: :json)
