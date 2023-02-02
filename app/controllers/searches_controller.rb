class SearchesController < ApplicationController
   def search
      @model=params[:model]#userかbook選択される
      @content=params[:content]#ﾕｰｻﾞｰが入力するﾜｰﾄﾞを受け取る
      @method=params[:method]#完全､部分､前方､後方一致いずれかが選択される
      if @model == 'user'#userを選択された場合
        @records=User.search_for(@content,@method)#Userモデルから探してくる
      else#そうじゃなければ
        @records=Book.search_for(@content,@method)#Bookモデルから探してくる
      end
    end
end
