class LikesController < ApplicationController
  def create
    @post = Post.find_by(id: params[:post_id])
    @like = @post.likes.new(author_id: current_user.id)
    if @like.save
      redirect_back(fallback_location: root_path)
    else
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
  end
end
