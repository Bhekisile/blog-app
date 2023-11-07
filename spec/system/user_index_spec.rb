require 'rails_helper'
# require 'capybara/rspec'

RSpec.describe 'User index page', type: :system do
  before(:each) do
    @user1 = User.create(name: 'Tom', photo: 'https://bit.ly/48MSO1Y', bio: 'Teacher from Mexico.', posts_counter: 1)
    @user2 = User.create(name: 'Lilly', photo: 'https://bit.ly/45fmtOi', bio: 'Teacher from Poland.', posts_counter: 2)
    @user3 = User.create(name: 'Jennifer', photo: 'https://bit.ly/45dJP6T', bio: 'Software Developer from Berlin.',
                         posts_counter: 3)
  end

  describe 'User contents' do
    before(:each) do
      visit users_path
    end

    it 'should see the username of all other users' do
      User.all.each do |user|
        expect(page).to have_content(@user1.name)
        expect(page).to have_content(@user2.name)
        expect(page).to have_content(@user3.name)
      end
    end

    it 'should see the profile picture of each user' do
      expect(page).to have_selector("img[src='https://bit.ly/48MSO1Y']")
    end

    it 'should see the number of posts each user has written' do
      expect(page).to have_content('Number of posts: 1')
      expect(page).to have_content('Number of posts: 2')
      expect(page).to have_content('Number of posts: 3')
    end
  end

  describe 'User interactions' do
    before(:each) do
      visit users_path
  end

    it 'should redirect to that user\'s show page, when click on a user' do
      first("a[href='#{user_path(@user1)}']").click

      expect(page).to have_current_path(user_path(@user1))
    end
  end
end
