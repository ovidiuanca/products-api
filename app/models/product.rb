class Product < ApplicationRecord
  ELECTRONICS = 'Electronics'.freeze
  BOOKS = 'Books'.freeze
  FASHION = 'Fashion'.freeze

  CATEGORIES = [ELECTRONICS, BOOKS, FASHION]

  validates_presence_of :name, :price, :category
end
