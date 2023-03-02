class PostsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false if @user.nil?
    @posts = @user.posts.includes(comments: :author)
    render :index, locals: { user: @user, posts: @posts }
  end

  def show
    @post = Post.find_by(author_id: params[:user_id], id: params[:id])
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false if @post.nil?

    @comments = @post.comments
    @user = @post.author
    render :show, locals: { post: @post, comments: @comments, user: @user }
  end
end
