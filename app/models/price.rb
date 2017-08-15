class Price < ApplicationRecord
  belongs_to :product
  belongs_to :pharmacy
end
