json.extract! recipe_food, :id, :recipe_item_id, :food_id, :quantity, :created_at, :updated_at
json.url recipe_food_url(recipe_food, format: :json)
