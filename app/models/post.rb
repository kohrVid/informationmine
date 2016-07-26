class Post < ActiveRecord::Base
  has_many :post_tags
  has_many :tags, through: :post_tags

  def self.offset_value(page_number, page_size)
    (page_number - 1) * page_size
  end

  def self.no_next(page_size, page_number)
    Post.limit(page_size).offset((page_number - 1) * page_size).to_a.empty?
  end
end
