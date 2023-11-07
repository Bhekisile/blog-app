require 'rails_helper'
RSpec.describe 'User show page', type: :system do
  let(:user)  { User.create(name: 'Tom', photo: 'https://bit.ly/48MSO1Y', bio: 'Teacher from Mexico.', posts_counter: 1) }
  let!(:post1) { Post.create(author: @user, title: 'Hello', text: 'This is my first post',
  likes_counter: 0) }
  let!(:post2) { Post.create(author: @user, title: 'Testing', text: 'Learn integration test',
  likes_counter: 0) }
  let!(:post3) { Post.create(author: @user, title: 'Learn JavaScript', text: 'Second post for JavaScript',
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
    it 'should see a button that lets me view all of a user\'s posts.' do
      expect(page).to have_selector("a[href='#{user_posts_path(user)}']")
    end
    it 'redirects me to the user\'s post\'s index page, when I click see all posts' do
      click_link 'See all posts', href: user_posts_path(user)
      expect(page).to have_current_path(user_posts_path(user))
    end
  end
end
