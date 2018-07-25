class Category < ApplicationRecord
  has_many :books

  scope :by_name, ->{select :id, :name}
end
