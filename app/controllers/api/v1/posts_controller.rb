class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, only: [:create, :destroy, :update]
  before_action :check_admin, only: [:create, :destroy, :update, :patch]

  def index
    load_posts 
    
    render json: { 
      data: ActiveModel::Serializer::CollectionSerializer.new(@posts, serializer: PostSerializer),
      meta: {
          total_pages: @posts.total_pages,
          current_page: @posts.current_page,
          next_page: @posts.next_page,
          prev_page: @posts.prev_page,
          total_count: @posts.total_count
      },
    }, status: :ok
  end

  def show
    @post = Post.find(params[:id])
    load_nearby_posts

    render json: { 
      post: PostSerializer.new(@post), 
      nearby_posts: ActiveModel::Serializer::CollectionSerializer.new(@nearby_posts, serializer: PostSerializer) 
    }, status: :ok
  end


  def load_nearby_posts
    @nearby_posts = Post.where("id > ?", params[:id]).limit(4)

    if @nearby_posts.length < 4
      remaining_posts = Post.where("id < ?", params[:id]).limit(4 - @nearby_posts.length)
      @nearby_posts += remaining_posts.to_a    
    end
  end

  private

  def load_posts
    @posts ||= 
      Post
        .order(date: :desc)
        .page(params[:page])
        .per(params[:per_page])
  end

  def nearby_posts 
    Post.where("id != ?", @post.id).limit(4)
  end

  def check_admin
    unless current_user.admin?
      flash[:alert] = "You don't have permission to do that."
      redirect_to root_path
    end
  end
end
