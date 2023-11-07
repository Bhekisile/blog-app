require 'rails_helper'

RSpec.describe 'User show page', type: :system do
  let(:user)  { User.create(name: 'Tom', photo: 'https://bit.ly/48MSO1Y', bio: 'Teacher from Mexico.') }
  let!(:post1) { Post.create(title: 'Hello World!', text: 'This is my first post.', author: user, comments_counter: 0,
  likes_counter: 0) }
  let!(:post2) { Post.create(title: 'Testing', text: 'Learn integration test', author: user, comments_counter: 0,
  likes_counter: 0) }
  let!(:post3) { Post.create(title: 'Learn JavaScript', text: 'Second post for JavaScript', author: user, comments_counter: 0,
  likes_counter: 0) }

  describe 'Page content testing' do
    before(:each) do
      visit user_path(user)
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

    it 'should see the user\'s bio' do
      expect(page).to have_content(user.bio)
    end

    it 'should see the user\'s first 3 posts' do
      expect(page).to have_content(post1.text)
      expect(page).to have_content(post2.text)
      expect(page).to have_content(post3.text)
    end

    it 'should see a button that lets me view all of a user\'s posts.' do
      expect(page).to have_selector("a[href='#{user_posts_path(user)}']")
    end

    it 'redirects me to that post\'s show page, when I click a user\'s post.' do
      click_link 'Show details', href: user_post_path(user, posts[1])
      expect(page).to have_current_path(%r{/users/\d+/posts/\d+})
    end

    it 'redirects me to the user\'s post\'s index page, when I click see all posts' do
      click_link 'See all posts', href: user_posts_path(user)
      expect(page).to have_current_path(user_posts_path(user))
    end
  end
end
