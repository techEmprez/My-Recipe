class AddInventoryToShoppingList < ActiveRecord::Migration[7.0]
  def change
    add_reference :shopping_lists, :inventory, null: false, foreign_key: true
  end
end
