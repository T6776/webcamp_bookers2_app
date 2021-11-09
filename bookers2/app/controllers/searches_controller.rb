class SearchesController < ApplicationController
  def search
    @model = params["model"]
    @method = params["method"]
    @content = params["content"]
    @records = search_for(@model,@method,@content)
  end

  private
  def search_for(model,method,content)
    if model == 'user'
      if method == 'perfect'
        User.where(name:content)
      elsif method == 'prefix'
        User.where('name LIKE ?', content+'%')
      elsif method == 'backward'
        User.where('name LIKE ?', '%'+content)
      else
        User.where('name LIKE ?', '%'+content+'%')
      end

    elsif model == 'book'
      if method == 'perfect'
        Book.where(title:content)
      elsif method == 'prefix'
        Book.where('title LIKE ?', content+'%')
      elsif method == 'backward'
        Book.where('title LIKE ?', '%'+content)
      else
        Book.where('title LIKE ?', '%'+content+'%')
      end

    elsif model == 'category'
      if method == 'perfect'
        Category.where(category_name:content)
      elsif method == 'prefix'
        Category.where('category_name LIKE ?', content+'%')
      elsif method == 'backward'
        Category.where('category_name LIKE ?', '%'+content)
      else
        Category.where('category_name LIKE ?', '%'+content+'%')
      end
    end
  end

end
