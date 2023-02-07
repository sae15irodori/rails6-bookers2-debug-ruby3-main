class ChatsController < ApplicationController
  #相互フォローしていない人とチャットしようとすると投稿一覧ページへ飛ばされる
  before_action :reject_non_related, only: [:show]

  def show
    @user = User.find(params[:id])#チャット相手を取得
    rooms = current_user.user_rooms.pluck(:room_id)#ｶﾚﾝﾄﾕｰｻﾞｰのお部屋idを全て取得
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)#その中に、チャット相手とのお部屋があるか確認

    unless user_rooms.nil?#チャット相手とのお部屋が空じゃなければ
      @room = user_rooms.room#自分と相手が紐づいているroomを代入
    else#自分と相手のお部屋がなければ
      @room = Room.new#新しくお部屋を作る
      @room.save#その部屋を保存
      UserRoom.create(user_id: current_user.id, room_id: @room.id)#自分の中間テーブルを作る
      UserRoom.create(user_id: @user.id, room_id: @room.id)#チャット相手の中間テーブルも作る
    end
    @chats = @room.chats#お部屋の会話内容を取得　一覧用の変数
    @chat = Chat.new(room_id: @room.id)#空の会話を作成。どのお部屋の会話かid入れる。投稿用の変数
  end

  def create
    @chat = current_user.chats.new(chat_params)#ｶﾚﾝﾄﾕｰｻﾞｰの空の会話箱を用意
    @chat.save#会話内容を保存
    #redirect_to request.referer#同じページへリダイレクト
    #views/chats/create.js.erbを表示
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def reject_non_related
    user = User.find(params[:id])#相手ﾕｰｻﾞｰの情報取得
    #自分が相手をフォローしていない　かつ　相手が自分をフォローしていないならば
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to books_path#投稿一覧ページへ飛ばされる
    end
  end
end