class Item < ApplicationRecord
  acts_as_list scope: :category
  
  belongs_to :category

  validates :name, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :minimum, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
