class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, foreign_key: 'food_id'
  has_many :inventory_foods, foreign_key: 'food_id'

  validates :name, presence: true, uniqueness: true
  validates :measurement_unit, presence: true
  validates :price, numericality: { greater_than: 0 }
end
