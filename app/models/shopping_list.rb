class ShoppingList < ApplicationRecord
  belongs_to :inventory
  belongs_to :recipe
end
