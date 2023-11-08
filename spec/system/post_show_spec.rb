require 'rails_helper'

RSpec.describe 'Post show page', type: :system do
  describe 'Should display post details of a user' do
    user = User.create(name: 'Tom', photo: 'https://bit.ly/48MSO1Y', bio: 'Teacher from Mexico.')

    let!(:posts) do
      [
        Post.create(title: 'Hello World!', text: 'This is my first post.', author: user, comments_counter: 0,
                  likes_counter: 0, author_id: user.id)
    ]
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
      posts.each do |post|
      expect(page).to have_content("#{post.title} by #{post.author.name}")
      end
    end

    it 'Display count of comments' do
      posts.each do |post|
      expect(page).to have_content("Comments : #{post.comments_counter}")
      end
    end

    it 'Display count of likes' do
      posts.each do |post|
      expect(page).to have_content("Likes : #{post.likes_counter}")
      end
    end

    it 'Should see the post body.' do
      posts.each do |post|
      expect(page).to have_content(post.text.to_s)
      end
    end

    it 'Should see the username of each commentor.' do
      posts.each do |post|
      post.comments.all.each do |comment|
        expect(page).to have_content(comment.author.name.to_s)
      end
      end
    end

    it 'Should see the comment each commentor left.' do
      posts.each do |post|
      post.comments.all.each do |comment|
        expect(page).to have_content(comment.text.to_s)
      end
    end
    end

    it 'Displays count of comments' do
      posts.each do |post|
      expect(page).to have_content("Comments : #{post.comments.count}")
      end
    end

    it 'Display count of likes' do
      posts.each do |post|
      expect(page).to have_content("Likes : #{post.likes_counter}")
      end
    end
  end
end


