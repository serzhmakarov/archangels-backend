class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :update]
  before_action :check_admin, only: [:create, :destroy, :update]
  
  def index
    @posts = Post.order(created_at: :desc)
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

  def update
    @post = Post.find(params[:id])
  
    if @post.update(post_params)
      if post_params[:photo].present?
        @post.photo.purge
        @post.photo.attach(post_params[:photo])
      end
      render json: @post, serializer: PostSerializer, status: :ok
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

  def check_admin
    unless current_user.admin?
      flash[:alert] = "You don't have permission to do that."
      redirect_to root_path
    end
  end

  def post_params
    params.require(:post).permit(:name, :short_description, :long_description, :feedback, :date, :photo)
  end
end
