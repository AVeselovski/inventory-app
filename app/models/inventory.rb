class Inventory < ApplicationRecord
  has_many :categories, dependent: :destroy
end
