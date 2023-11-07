require 'rails_helper'

RSpec.describe 'User post index page', type: :system do
  let(:user) { User.create(name: 'Tom', photo: 'https://bit.ly/48MSO1Y', bio: 'Teacher from Mexico.', posts_counter: 1) }
  let!(:posts) do
    [
      Post.create(title: 'Hello World!', text: 'This is my first post.', author: user, comments_counter: 0,
                  likes_counter: 0),
      Post.create(title: 'Testing', text: 'Learn integration test', author: user, comments_counter: 0,
                  likes_counter: 0)
    ]
  end

  let!(:comments) do
    [
      Comment.create(text: 'Post 1 comment', author: user, post: posts[0]),
      Comment.create(text: 'Post 2 comment', author: user, post: posts[1])
    ]
  end

  describe 'Post index page' do
    before(:each) do
      visit user_posts_path(user)
    end

    it 'should see the user\'s profile picture' do
      expect(page).to have_selector("img[src='https://bit.ly/48MSO1Y']")
    end

    it 'should see the user\'s username' do
      expect(page).to have_content(user.name)
    end

    it 'should see the number of posts the user has written' do
      expect(page).to have_content(user.posts_counter)
    end

    it 'should see a post\'s title' do
      posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it 'should see some of the post\'s body' do
      posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'Display count of likes' do
      posts.each do |post|
      expect(page).to have_content(post.likes_counter)
      end
    end

    it 'should see the first comments on a post' do
      expect(page).to have_content('Post 1 comment')
    end

    it 'should see a section for pagination if there are more posts than fit on the view' do
      expect(page).to have_link('Pagination')
    end

    it 'redirects me to that post\'s show page, when click on a post' do
      click_link 'Show details', href: user_post_path(user, posts[1])
      expect(page).to have_current_path(%r{/users/\d+/posts/\d+})
    end
  end
end
