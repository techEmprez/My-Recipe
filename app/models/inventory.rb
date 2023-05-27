class Inventory < ApplicationRecord
  belongs_to :user
  has_many :inventory_foods, foreign_key: 'food_id'
  has_many :shopping_lists

  validates :name, presence: true
  validates :description, presence: true
end
