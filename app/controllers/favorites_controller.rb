class FavoritesController < ApplicationController

  def create#いいね保存
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    #redirect_to request.referer非同期通信の為リダイレクトしない。が、javascriptリクエストとなる。
    #アクション実行後はcreate.js.erbファイルを探す
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    #redirect_to request.referer非同期通信の為リダイレクトしない。が、javascriptリクエストとなる
    #アクション実行後はdestroy.js.erbファイルを探す
  end
end
