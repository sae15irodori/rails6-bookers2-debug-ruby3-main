class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]#edit追記urlでｱｸｾｽ不可にする

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end#追記

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])#追記
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."#パスをusers_path(@user)より変更
    else
      render :edit #"show"より変更
    end
  end


    def followings
      user = User.find(params[:id])#見たいｰｻﾞｰのデータ取得
      @users = user.following#上の行で取得したユーザーがフォロー中の全ユーザーデータ取得
    end

    def followers
      user = User.find(params[:id])#見たいユーザーのデータ取得
      @users = user.followers#上の行で取得したユーザーのフォロワーの全ユーザーデータ取得
    end
end



  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
