class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :shopping_lists

  validates :name, presence: true, length: { minimum: 3, maximum: 500 }
  validates :description, presence: true, length: { minimum: 3, maximum: 1000 }
  validates :preparation_time, presence: true, length: { minimum: 1, maximum: 15 }
  validates :cooking_time, presence: true, length: { minimum: 1, maximum: 15 }
end
