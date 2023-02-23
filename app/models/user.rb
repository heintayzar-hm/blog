class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy

  validates_associated :posts, :comments, :likes

  def get_recent_posts
    posts.order(updated_at: :desc).limit(3)
  end
end
