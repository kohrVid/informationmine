class Post < ActiveRecord::Base
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :answers, class_name: "Post", foreign_key: :parent_id
  belongs_to :question, class_name: "Post", foreign_key: :parent_id
  belongs_to :author, class_name: "Geek", foreign_key: :owner_user_id

  scope :questions, proc { where(parent_id: nil) } 
  scope :paginated, ->(page_number, page_size) { limit(page_size).offset((page_number - 1) * page_size) }

  after_create :send_notification_email


  def self.search_results(search_term, page_number, page_size)
    self.search("*" + search_term + "*", ranker: :bm25,
	       	per_page: page_size, page: page_number, sql: { include: :tags })
  end

  def self.no_next(next_page_number, page_size)
    self.paginated(next_page_number, page_size).empty?
  end

  def self.no_next_search(next_search_term, page_number, page_size)
    self.search_results(next_search_term, page_number, page_size).empty?
  end


  private
    def is_answer?
      parent_id
    end

    def send_notification_email
      PostMailer.notify_answer(self).deliver_now if is_answer?
    end
end
