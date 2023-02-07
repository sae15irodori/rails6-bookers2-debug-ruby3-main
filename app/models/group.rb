class Group < ApplicationRecord
  has_many :group_users
  has_many :usres, through: :group_users

  validates :name, presence: true#名前空白ダメ
  validates :introduction, presence: true#自己紹介文空白ダメ
  #attachment :image, destroy: false#画像の削除できない
  has_one_attached :profile_image
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
