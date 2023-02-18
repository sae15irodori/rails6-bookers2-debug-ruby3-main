class Book < ApplicationRecord
  belongs_to :user#has_manyより変更
  has_many :favorites, dependent: :destroy#追記 いいね機能と関連付け
  has_many :book_comments, dependent: :destroy#追記　コメント機能と関連付け
  has_many :favorited_users, through: :favorites, source: :user
  has_many :view_counts, dependent: :destroy
  has_many :book_tag_relations, dependent: :destroy
  has_many :tags, through: :book_tag_relations, dependent: :destroy

  mount_uploader :file, AudiofileUploader

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)#関連付けしたfavoriteモデルに存在ある？→user_idカラムにuserと同じid
  end


  def self.search_for(content, method)
    if method == 'perfect'#完全一致
      Book.where(title: content)#titleカラムからcontentに入力されたﾜｰﾄﾞ取得
    elsif method == 'forward'#前方一致
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'#後方一致
      Book.where('title LIKE ?', '%'+content)
    else
      Book.where('title LIKE ?', '%'+content+'%')#部分一致
    end
  end

end
