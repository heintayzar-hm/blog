class Api::V1::PostsController < Api::V1::ApiController

  load_and_authorize_resource param_method: :post_params, only: %i[create]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    render json: { posts: @posts, message: "Posts successfully retrieved" , status: :ok}
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments = @post.comments
    render json: { post: @post,comments: @comments, message: "Post successfully retrieved" , status: :ok}
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.new(post_params)
    if @post.save
      render json: { post: @post, message: "Post successfully created" , status: :ok}
    else
      render json: { message: "Post not created" , status: :unprocessable_entity}
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
