class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  has_many :likes, foreign_key: 'post_id', dependent: :destroy
  has_many :comments, foreign_key: 'post_id', dependent: :destroy
  validates_associated :likes, :comments

  def update_posts_counter
    author.increment!(:posts_counter)
  end

  def get_recent_comments
    comments.order(updated_at: :desc).limit(5)
  end
end
