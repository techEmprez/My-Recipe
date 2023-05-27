class InventoryShoppingsController < ApplicationController
  def index
    recent_shopping = ShoppingList.last
    @recipe = recent_shopping.recipe.recipe_foods
    @inventory = recent_shopping.inventory.inventory_foods
  end
end
