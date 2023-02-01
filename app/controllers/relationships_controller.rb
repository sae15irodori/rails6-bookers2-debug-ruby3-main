class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:followed_id])#フォローされる人のデータを取得
    current_user.follow(@user)#ログイン中ユーザーがフォローする(上の行で取得した人を)
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
  end
end
