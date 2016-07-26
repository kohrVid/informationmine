class PostsController < ApplicationController
  def index
    page_number = params[:page].nil? ? 1 : params[:page].to_i
    @page_size = params[:page_size].nil? ? 20 : params[:page_size].to_i
    @posts = Post.limit(@page_size).offset(
      Post.offset_value(page_number, @page_size)
    )
    @next_page = page_number + 1
    @previous_page = page_number - 1
  end

  
end
