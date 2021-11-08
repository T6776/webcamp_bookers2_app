class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :categorymaps, dependent: :destroy
  has_many :categories, through: :categorymaps

  def save_category(sent_categories)
    current_categories = self.categories.pluck(:category_name) unless self.categories.nil?
    old_categories = current_categories - sent_categories
    new_categories = sent_categories - current_categories

    old_categories.each do |old|
      self.categories.delete Category.find_by(category_name: old)
    end

    new_categories.each do |new|
      new_book_category = Category.find_or_create_by(category_name: new)
      self.categories << new_book_category
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
  validates :rate,numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true
end
