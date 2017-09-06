class Pharmacy < ApplicationRecord
  has_many :prices, :class_name => 'Price'
  has_many :products, through: :prices
  belongs_to :pharmacy_web, :class_name => 'PharmacyWeb'
  belongs_to :region
  belongs_to :user
end
