require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(name: 'Tom', photo: 'https://bit.ly/48MSO1Y', bio: 'Teacher from Mexico.', posts_counter: 3)
  post = Post.create(author: user, title: 'Title 1', text: 'First post from Prosper', comments_counter: 0, likes_counter: 0,
                     author_id: user.id)

  describe 'associations' do
    it 'belongs to author' do
      like = Like.reflect_on_association(:author)
      expect(like.macro).to eq(:belongs_to)
    end

    it 'belongs to post' do
      like = Like.reflect_on_association(:post)
      expect(like.macro).to eq(:belongs_to)
    end
  end

  describe '#update_post_likes_counter' do
    it 'Updates likes of the associated post' do
      like = Like.create(post: post, author: user, author_id: user.id)
      expect { like.update_post_likes_counter }.to change { post.reload.likes_counter }.by(1)
    end
  end
end
