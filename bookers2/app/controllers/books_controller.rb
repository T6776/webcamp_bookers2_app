class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to user_path(@user.id)
  end

  def index
    @user = User.find(params[:id])
    @books = Book.all
  end

  def show
   @book = Book.find(params[:id])
  end

  def destroy
  end


  private

  def post_image_params
    params.require(:book).permit(:title, :body, :user_id)
  end



end
