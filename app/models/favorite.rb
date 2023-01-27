class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
end
#user,bookモデルと関連付け