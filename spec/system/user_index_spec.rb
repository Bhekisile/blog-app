require 'rails_helper'

RSpec.describe 'User Index Page', type: :system do
  before(:each) do
    @user1 = User.create(name: 'Tom', photo: 'https://bit.ly/48MSO1Y', bio: 'Teacher from Mexico.', posts_counter: 3)
    @user2 = User.create(name: 'Lilly', photo: 'https://bit.ly/45fmtOi', bio: 'Teacher from Poland.', posts_counter: 2)
    @user3 = User.create(name: 'Jennifer', photo: 'https://bit.ly/45dJP6T', bio: 'Software Developer from Berlin.',
                         posts_counter: 1)
  end

  describe 'User contents' do
    before(:each) do
      visit users_path
    end

    it 'should see the username of all other users' do
      User.all.each do |_user|
        expect(page).to have_content(@user1.name)
        expect(page).to have_content(@user2.name)
        expect(page).to have_content(@user3.name)
      end
    end

    it 'Should see the profile picture for each user.' do
      expect(page).to have_selector("img[src='https://bit.ly/48MSO1Y']")
    end

    it 'Should see the number of posts each user has written.' do
      expect(page).to have_content('Number of posts: 3')
      expect(page).to have_content('Number of posts: 2')
      expect(page).to have_content('Number of posts: 1')
    end
  end
end
