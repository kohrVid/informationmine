require "./lib/search.rb"
class PostsController < ApplicationController
  before_action :paginate_variables, except: [:show, :create]

  def index
    @posts = Post.includes(:tags).paginated(@page_number, @page_size)
    @tags = Tag.all
  end

  def search
    @search_term = params[:search_term]
    @posts = Post.search_results(@search_term, @page_number, @page_size)
    @total_results = @posts.meta["total"].to_i
    @suggestion = Search.make_suggestion(@search_term, @total_results)
  end

  def show
    @post = Post.includes(:tags).find(params[:id])
  end

  def create
    #@answer = Post.create(post_params, author: current_geek)
    @answer = Post.new(post_params)
    @answer.author = current_geek
    @answer.save!
    if @answer.save
      redirect_to post_path(id: @answer.parent_id), notice: t("posts.created")
    else
      render :show
    end
  end


  private

    def paginate_variables
      @page_number = params[:page].nil? ? 1 : params[:page].to_i
      @page_size = params[:page_size].nil? ? 20 : params[:page_size].to_i
      @next_page = @page_number + 1
      @previous_page = @page_number - 1
    end

    def post_params
      params.require(:post).permit(:parent_id, :title, :body)
    end
  
end
