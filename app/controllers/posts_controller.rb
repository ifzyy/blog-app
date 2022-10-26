class PostsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @posts = Post.where(author_id: @user.id)
  end

  def show
    @post = Post.find(params[:id])
  end
end