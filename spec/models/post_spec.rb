require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  user = User.create(name: 'Prosper', photo: 'https://unsplash.com/photos/64YrPKiguAE', posts_counter: 0,
                     bio: 'Student at Microverse')
  post = Post.create(title: 'Title 1', text: 'First post from Prosper', comments_counter: 0, likes_counter: 0,
                     author_id: user.id)

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

    # it 'is valid with a comments counter of 0' do
    #   post.author = user
    #   post.comments_counter = 0
    #   post.likes_counter = 0
    #   expect(post).to be_valid
    # end

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

  # describe '#recent_comments' do
  #   it 'returns the three most recent comments' do
  #     user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
  # posts_counter: 0, bio: 'Teacher from Poland.')
  #     first_post = Post.create(author: user, title: 'Hi, am back',
  # text: 'This is the second post of Lilly', created_at: Time.current)

  #     Comment.create(post: first_post, user: user, text: 'Comment one!')
  #     comment2 = Comment.create(post: first_post, user: user, text: 'Comment two!')
  #     comment3 = Comment.create(post: first_post, user: user, text: 'Comment three!')
  #     comment4 = Comment.create(post: first_post, user: user, text: 'Comment four!')
  #     comment5 = Comment.create(post: first_post, user: user, text: 'Comment five!')
  #     comment6 = Comment.create(post: first_post, user: user, text: 'Comment six!')

  #     recent_comment = first_post.recent_comments.to_a
  #     expect(recent_comment).to eq([comment6, comment5, comment4, comment3, comment2])
  #   end

  #   it 'returns the specific number of recent comments' do
  #     user1 = User.create(name: 'Jozi', photo: 'https://unsplash.com/photos/64YrPKiguAE',
  # posts_counter: 0, bio: 'Software Developer from Cape Town.')
  #     last_post = Post.create(author: user1, title: 'Hello there are you OK',
  # text: 'This is my eighth post', created_at: Time.current)

  #     Comment.create(post: last_post, user: user1, text: 'Comment one!')
  #     Comment.create(post: last_post, user: user1, text: 'Comment two!')
  #     Comment.create(post: last_post, user: user1, text: 'Comment three!')
  #     Comment.create(post: last_post, user: user1, text: 'Comment four!')

  #     recent_comment = last_post.recent_comments(2)
  #     expect(recent_comment.size).to eq(2)
  #   end
  # end
end
