class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :posts, class_name: 'Post', foreign_key: 'post_id'

  after_save :update_likes_counter
  after_destroy :update_likes_counter

  private

  def update_likes_counter
    if destroyed?
      post.decrement!(:likes_counter)
    else
      post.increment!(:likes_counter)
    end
  end
end
