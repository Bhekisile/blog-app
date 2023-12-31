require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  user = User.create(name: 'Tom', photo: 'https://bit.ly/48MSO1Y', bio: 'Teacher from Mexico.', posts_counter: 3)
  post = Post.create(title: 'Hello World!', text: 'This is my first post.', author: user, comments_counter: 0,
                     likes_counter: 0, author_id: user.id)

  describe 'validations' do
    it 'title should be present' do
      post.title = nil
      expect(post).to_not be_valid
    end

    it 'title not to exceed 250 character' do
      post.title = 'a' * 251
      expect(post).to_not be_valid
    end

    it 'comments_counter to be greater or equal to zero' do
      post.comments_counter = -1
      expect(post).to_not be_valid
    end

    it 'comments_counter to be an integer' do
      post.comments_counter = 1.5
      expect(post).to_not be_valid
    end

    it 'comments_counter to be a number' do
      post.comments_counter = 'text'
      expect(post).to_not be_valid
    end

    it 'likes_counter to be greater or equal to zero' do
      post.likes_counter = -1
      expect(post).to_not be_valid
    end
  end

  describe 'associations' do
    it 'belongs to author' do
      post = Post.reflect_on_association(:author)
      expect(post.macro).to eq(:belongs_to)
    end

    it 'has many likes' do
      post = Post.reflect_on_association(:likes)
      expect(post.macro).to eq(:has_many)
    end

    it 'has many comments' do
      post = Post.reflect_on_association(:comments)
      expect(post.macro).to eq(:has_many)
    end
  end

  describe '#recent_comments' do
    it 'returns the specific number of recent comments' do
      user1 = User.create!(name: 'Jozi', photo: 'https://unsplash.com/photos/64YrPKiguAE',
                           posts_counter: 0, bio: 'Software Developer from Cape Town.')
      last_post = Post.create!(author: user1, title: 'Hello there are you OK',
                               text: 'This is my eighth post', comments_counter: 0, likes_counter: 0)

      last_post.comments.create(post: last_post, author: user1, text: 'Comment one!')
      last_post.comments.create(post: last_post, author: user1, text: 'Comment two!')
      last_post.comments.create(post: last_post, author: user1, text: 'Comment three!')
      last_post.comments.create(post: last_post, author: user1, text: 'Comment four!')
      last_post.comments.create(post: last_post, author: user1, text: 'Comment five!')
      last_post.comments.create(post: last_post, author_id: user1, text: 'Comment six!')

      recent_comment = last_post.recent_comments
      expect(recent_comment.size).to eq(5)
    end
  end

  describe '#update_user_posts_counter' do
    user2 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                        bio: 'Teacher from Mexico.')
    subject = Post.create(title: 'Hello World!', text: 'This is my first post.', author: user2, comments_counter: 0,
                          likes_counter: 0)

    it 'increments the post counter on the associated post' do
      expect { subject.send(:update_user_posts_counter) }.to change { user2.reload.posts_counter }.by(1)
    end
  end
end
