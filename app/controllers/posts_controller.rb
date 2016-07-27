class PostsController < ApplicationController
  before_action :paginate_variables

  def index
    @posts = Post.pages(@page_number, @page_size)
  end

  def search
    @search_term = params[:search_term]
    @posts = Post.search_results(@search_term, @page_number, @page_size)
    @total_results = @posts.meta["total"].to_i
    @suggestion = make_suggestion(@search_term, @total_results)
  end


  private

    def paginate_variables
      @page_number = params[:page].nil? ? 1 : params[:page].to_i
      @page_size = params[:page_size].nil? ? 20 : params[:page_size].to_i
      @next_page = @page_number + 1
      @previous_page = @page_number - 1
    end
  
end
