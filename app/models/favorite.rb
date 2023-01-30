class Favorite < ApplicationRecord
  belongs_to :user#1:NのN側
  belongs_to :book#1:NのN側
end
#user,bookモデルと関連付け