class Product < ApplicationRecord
  has_and_belongs_to_many :groups
  has_many :prices, :class_name => 'Price'
  has_many :pharmacies, through: :prices
end
