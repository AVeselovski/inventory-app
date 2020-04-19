class Item < ApplicationRecord
  acts_as_list scope: :category
  belongs_to :category

  validates :name, presence: true
  validates :quantity, presence: true
end
