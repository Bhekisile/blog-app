require 'rails_helper'

RSpec.describe 'Post show page', type: :system do
  describe 'Should display post details of a user' do
    user = User.create(name: 'Tom', photo: 'https://bit.ly/48MSO1Y', bio: 'Teacher from Mexico.')

    let!(:posts) do
      Post.create(title: 'Hello World!', text: 'This is my first post.', author: user, comments_counter: 0,
                  likes_counter: 0)
    end

    let(:comments) do
      Comment.create(text: 'Post 1 comment', author: user, post: posts[0])
    end

    before do
      visit user_post_path(user, posts)
    end

    it 'Display header text' do
      expect(page).to have_content('Posts details')
    end

    it 'Display post title by an author' do
      expect(page).to have_content("#{posts.title} by #{posts.author.name}")
    end

    it 'Display count of comments' do
      expect(page).to have_content("Comments : #{posts.comments_counter}")
    end

    it 'Display count of likes' do
      expect(page).to have_content("Likes : #{posts.likes_counter}")
    end

    it 'Should see the post body.' do
      expect(page).to have_content(posts.text.to_s)
    end

    it 'Should see the username of each commentor.' do
      posts.comments.all.each do |comment|
        expect(page).to have_content(comment.author.name.to_s)
      end
    end

    it 'Should see the comment each commentor left.' do
      posts.comments.all.each do |comment|
        expect(page).to have_content(comment.text.to_s)
      end
    end

    it 'Displays count of comments' do
      expect(page).to have_content("Comments : #{posts.comments.count}")
    end

    it 'Display count of likes' do
      expect(page).to have_content("Likes : #{posts.likes_counter}")
    end
  end
end
