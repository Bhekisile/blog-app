require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: 'Tom', photo: 'https://bit.ly/48MSO1Y', bio: 'Teacher from Mexico.', posts_counter: 3) }

  before { user.save }

  it 'name should be present' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'posts_counter to be greater or equal to zero' do
    user.posts_counter = -1
    expect(user).to_not be_valid
  end

  it 'posts_counter to be an integer' do
    user.posts_counter = 1.5
    expect(user).to_not be_valid
  end

  it 'posts_counter to be a number' do
    user.posts_counter = 'text'
    expect(user).to_not be_valid
  end
end

describe 'associations' do
  it 'has many posts' do
    association = User.reflect_on_association(:posts)
    expect(association.macro).to eq(:has_many)
  end

  it 'has many comments' do
    association = User.reflect_on_association(:comments)
    expect(association.macro).to eq(:has_many)
  end

  it 'has many likes' do
    association = User.reflect_on_association(:likes)
    expect(association.macro).to eq(:has_many)
  end
end

describe '#recent_posts' do
  it 'returns the three most recent posts' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    user.posts.create(author: user, title: 'Post 1', text: 'This is my first post')
    post2 = user.posts.create(author: user, title: 'Post 2', text: 'This is my second post')
    post3 = user.posts.create(author: user, title: 'Post 3', text: 'This is my third post')
    post4 = user.posts.create(author: user, title: 'Post 4', text: 'This is my third post')

    recent_post = user.recent_posts
    expect(recent_post).to eq([post2, post3, post4])
  end
end
