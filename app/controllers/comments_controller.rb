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

  def destroy
    @user = User.find_by(id: params[:user_id])
    @post = @user.posts.find_by(id: params[:post_id])
    @comment = @post.comments.find_by(id: params[:comment_id])
    return render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false if @comment.nil?

    redirect_to user_post_path(@user, params[:post_id])
    if @comment.destroy
      flash[:notice] = 'Comment deleted successfully'
    else
      flash[:alert] = ['Comment not deleted']
    end
  end
end
