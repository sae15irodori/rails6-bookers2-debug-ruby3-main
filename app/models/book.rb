class Book < ApplicationRecord
  belongs_to :user#has_manyより変更
  has_many :favorites, dependent: :destroy#追記
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
