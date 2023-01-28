class FavoritesController < ApplicationController

  def create#いいね保存
    book = Book.find(params[:id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    redirect_to book_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    book = current_user.favorites.find_by(book_id: book.id)
    book.destroy
    redirect_to book_path(book)
  end
end
