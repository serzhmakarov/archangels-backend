class Api::V1::PostsController < ApplicationController
  def index
    @posts = Post.all
    render json: @posts, each_serializer: PostSerializer, status: :ok
  end

  def show
    @post = Post.find(params[:id])
    render json: @post, serializer: PostSerializer, status: :ok
  end

  def create
    @post = Post.new(post_params)
    @post.photo.attach(post_params[:photo])

    if @post.save
      render json: @post, serializer: PostSerializer, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    render json: { status: 'success', message: 'Post was successfully deleted.' }, status: :ok
  end

  private

  def post_params
    params.require(:post).permit(:name, :description, :date, :photo)
  end
end
