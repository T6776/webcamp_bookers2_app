class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    category_list = params[:book][:category_name].delete(' ').delete('　').split(',')
    if @book.save
      @book.save_category(category_list)
      redirect_to book_path(@book), notice: 'You have created book successfully.'
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @category_list = Category.all
    @book = Book.new
    @user = current_user
    if params[:sort] == "rate"
      @books = Book.order(rate: "DESC")
    elsif params[:sort] == "updated_at"
      @books = Book.order(updated_at: "DESC")
    else
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @post_comment = PostComment.new
  end

  def edit
    @book = Book.find(params[:id])
    if  current_user != @book.user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id, :rate)
  end

  def sort_params
    params.permit(:sort)
  end



end
