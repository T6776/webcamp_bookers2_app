class Categorymap < ApplicationRecord
  belongs_to :book
  belongs_to :category
end
