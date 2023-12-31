require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.create(name: 'Tom', photo: 'https://bit.ly/48MSO1Y', bio: 'Teacher from Mexico.', posts_counter: 0)
  Post.create(title: 'Title 1', text: 'First post from Tom', comments_counter: 0, likes_counter: 0,
              author_id: user.id)

  describe 'associations' do
    it 'belongs to author' do
      comment = Comment.reflect_on_association(:author)
      expect(comment.macro).to eq(:belongs_to)
    end

    it 'belongs to post' do
      comment = Comment.reflect_on_association(:post)
      expect(comment.macro).to eq(:belongs_to)
    end
  end

  # describe '#update_post_comments_counter' do
  #   it 'Updates comment of the associated post' do
  #     comment = Comment.create(post_id: post.id, author: user, text: 'This is the second comment.')
  #     expect(post.comments_counter).to eq(0)
  # expect { comment.update_post_comments_counter }.to change { post.reload.comments_counter }.by(1)
  # end
  # end
end
