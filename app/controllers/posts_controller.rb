class PostsController < ApplicationController
  load_and_authorize_resource param_method: :post_params, only: %i[create]
  def index
    @user = User.find_by(id: params[:user_id])
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false if @user.nil?
    @posts = @user.posts.includes(comments: :author)
    render :index, locals: { user: @user, posts: @posts }
  end

  def show
    @post = Post.includes(comments: :author).find_by(author_id: params[:user_id], id: params[:id])
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false if @post.nil?

    @comments = @post.comments.includes(:author)
    @user = @post.author
    render :show, locals: { post: @post, comments: @comments, user: @user }
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(title: params[:post][:title], text: params[:post][:text])
    if @post.save
      redirect_to user_posts_path(current_user)
    else
      render :new
    end
  end

  def destroy
    @post = Post.find_by(author_id: params[:user_id], id: params[:post_id])   
    return render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false if @post.nil? 
    if @post.destroy     
      redirect_to user_posts_path(current_user)    
    else     
      redirect_to user_post_path(current_user, @post)   
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
