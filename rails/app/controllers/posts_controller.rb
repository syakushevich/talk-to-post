# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  # before_action :authenticate_user!

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.build(post_params)
    @post.status = :processing

    if @post.save
      TranscriptionJob.perform_async(@post.id)
      redirect_to @post, notice: "Post is being processed."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end

  private

  def post_params
    params.require(:post).permit(:audio)
  end
end
