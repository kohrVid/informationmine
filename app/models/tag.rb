class Tag < ActiveRecord::Base
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  scope :tagged_with, ->(name) { where(name: name) }
end
