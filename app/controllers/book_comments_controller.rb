class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])#コメントする投稿データを取得
    comment = current_user.book_comments.new(book_comment_params)#ｶﾚﾝﾄﾕｰｻﾞｰと関連づいてる空のｺﾒﾝﾄﾚｺｰﾄﾞ取得ｺﾒﾝﾄｶﾗﾑのみ保存
    comment.book_id = @book.id#上の行で取得したﾚｺｰﾄﾞの内、book_idｶﾗﾑとコメントする投稿のbook.idを結びつける
    comment.save
    @user = current_user
    #redirect_to book_path(@book.id)
  end

  def destroy
   BookComment.find(params[:id]).destroy
   #redirect_to request.referer　js.erbを探しに行く
  end

  private

    def book_comment_params
      params.require(:book_comment).permit(:comment)
    end
end
