class Geek < ActiveRecord::Base
  has_many :posts, foreign_key: :owner_user_id
  has_many :questions, class_name: "Post", foreign_key: :owner_user_id
  has_many :answers, class_name: "Post", foreign_key: :owner_user_id

end
