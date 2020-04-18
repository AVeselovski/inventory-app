class Category < ApplicationRecord
  acts_as_list
  has_many :items, ->{ order(position: :asc) }, dependent: :destroy

  scope :sorted, ->{ order(position: :asc) }

  validates :name, presence: true
end
