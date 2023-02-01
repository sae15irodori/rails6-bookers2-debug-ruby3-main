class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"#ﾌｫﾛｰするﾕｰｻﾞのﾃﾞｰﾀをUserモデルから取得できる
  belongs_to :followed, class_name: "User"#ﾌｫﾛｰされたﾕｰｻﾞｰのﾃﾞｰﾀをUserﾓﾃﾞﾙから取得できる
  
  validates :follower_id, presence: true#ﾌｫﾛするﾕｰｻﾞｰのid存在すればtrue
  validates :followed_id, presence: true#ﾌｫﾛｰされたﾕｰｻﾞｰのid存在すればtrue
  validates :follower_id, uniqueness: { scope: :followed_id }#ﾌｫﾛﾜｰがﾌｫﾛｰできるのは一人だけ
end
