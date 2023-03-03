class CommentsController < ApplicationController
  def new
    @user = User.find_by(id: params[:user_id])
    @post = @user.posts.find_by(id: params[:post_id])
    return render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false if @post.nil?

    @comment = @post.comments.new
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @post = @user.posts.find_by(id: params[:post_id])
    return render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false if @post.nil?

    @comment = @post.comments.new(text: params[:comment][:text], author_id: current_user.id)
    if @comment.save
      # if integreate into post show page, redirect to post show page
      redirect_to user_post_path(@user, params[:post_id])
    else
      render :new
    end
  end
end
