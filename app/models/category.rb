class Category < ApplicationRecord
  acts_as_list
  
  belongs_to :inventory
  has_many :items, ->{ order(position: :asc) }, dependent: :destroy

  scope :sorted, ->{ order(position: :asc) }

  validates :name, presence: true
end
