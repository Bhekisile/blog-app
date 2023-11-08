class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes

  after_initialize :set_defaults
  after_create :update_user_posts_counter

  def update_user_posts_counter
    author.increment!(:posts_counter)
  end

  def recent_comments
    comments.last(5)
  end

  def limit_sentence(content)
    words = content.split
    return content unless words.count > 40

    limited_words = words.take(40)
    "#{limited_words.join(' ')} . . ."
  end

  def set_defaults
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end
end
