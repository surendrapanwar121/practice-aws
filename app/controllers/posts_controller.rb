class PostsController < ApplicationController
  before_action :find_post, only: [:show, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @post
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

  def find_post
    @post = Post.find params[:id]
  end
end
