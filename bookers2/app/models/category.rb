class Category < ApplicationRecord
  has_many :categorymaps, dependent: :destroy
  has_many :books, through: :categorymaps
end
