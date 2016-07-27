class Post < ActiveRecord::Base
  has_many :post_tags
  has_many :tags, through: :post_tags

  def self.pages(page_number, page_size)
    self.limit(page_size).offset((page_number - 1) * page_size)
  end

  def self.search_results(search_term, page_number, page_size)
    self.search("*" + search_term + "*", ranker: :bm25,
	       	per_page: page_size, page: page_number)
  end

  def self.no_next(next_page_number, page_size)
    self.pages(next_page_number, page_size).empty?
  end

  def self.no_next_search(next_search_term, page_number, page_size)
    self.search_results(next_search_term, page_number, page_size).empty?
  end

end
