class BooksController < ApplicationController
  before_action :ensure_currect_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_n = Book.new#部分ﾃﾝﾌﾟﾚｰﾄへ
    @user = @book.user#追記＃部分テンプレートへ
    @book_comment = BookComment.new
  end

  def index
    #@books = Book.all
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
      sort_by {|x|
        x.favorited_users.includes(:favorites).where(created_at: from...to).size}.reverse
    @book  = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy #deleteより変更
    @book = Book.find(params[:id])
    @book.destroy#destoyより
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)#titlemになってた
  end

  def ensure_currect_user
    @book = Book.find(params[:id])
      unless @book.user == current_user#@bookの.user(ﾕｰｻﾞｰ情報)がｶﾚﾝﾄﾕｰｻﾞｰじゃなければ
        redirect_to books_path
      end
  end
end
