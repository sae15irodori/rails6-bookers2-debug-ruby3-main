class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy#belongs_toより変更
  has_many :favorites, dependent: :destroy#追記いいね機能と関連付け
  has_many :book_comments, dependent: :destroy#追記コメント機能と関連付け

  #ﾌｫﾛｰ機能モデルとの関連付け。User,idと同じ数をRelationshipモデルさんに探してもらう。
  #follower_idカラム内から、数は探してもらう。そして、結びつけする
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy

  #@userと紐づいてるfollowe,followerそれぞれのidを取得して、userのデータを引っ張ることが出来るようになる
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  #DM機能
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms

  #閲覧数の表示
  has_many :view_counts, dependent: :destroy

  #グループ作成機能
  has_many :group_users
  has_many :groups, through: :group_users

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def favorited_by?(user)
    favites.exists?(user_id: user.id)
  end

  def follow(other_user)
    self.following << other_user#ある人がフォロー中のﾕｰｻﾞｰ配列に()の人を追加する
  end

  def unfollow(other_user)
    self.following.destroy(other_user)#ある人がフォロー中のﾕｰｻﾞｰ配列から()の人を消す
  end

  def following?(other_user)
    self.following.include?(other_user)#ある人がﾌｫﾛｰ済みのﾕｰｻﾞｰと()の人一致する場合trueを返す
  end


  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end


end
