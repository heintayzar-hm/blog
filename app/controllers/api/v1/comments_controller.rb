class Api::V1::CommentsController < Api::V1::ApiController
  load_and_authorize_resource param_method: :comment_params, only: %i[create]
  def index
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comments = @post.comments
    render json: { comments: @comments, message: 'Comments successfully retrieved', status: :ok }
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    render json: { comment: @comment, message: 'Comment successfully retrieved', status: :ok }
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.new(comment_params.merge(author_id: current_user.id))
    if @comment.save
      render json: { comment: @comment, message: 'Comment successfully created', status: :ok }
    else
      render json: { message: 'Comment not created', status: :unprocessable_entity }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
