class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes, foreign_key: 'post_id', dependent: :destroy
  has_many :comments, foreign_key: 'post_id', dependent: :destroy
  validates_associated :likes, :comments
  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_posts_counter
  after_destroy :update_posts_counter
  def recent_comments
    comments.order(updated_at: :desc).limit(5)
  end

  private

  def update_posts_counter
    if destroyed?
      author.decrement!(:posts_counter)
    else
      author.increment!(:posts_counter)
    end
  end
end
