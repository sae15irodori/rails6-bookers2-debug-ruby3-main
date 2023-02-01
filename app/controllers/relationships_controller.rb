class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])#フォローされる人のデータを取得
    current_user.follow(@user)#ログイン中ユーザーがフォローする(上の行で取得した人を)
    redirect_to request.referer
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
  end
end
