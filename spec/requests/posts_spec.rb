require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    user = User.create!(name: 'Zenaye', posts_counter: 0)
    it 'returns a successful response' do
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'renders the correct placeholder text in the response body' do
      get user_posts_path(user)
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'GET /show' do
    user = User.create!(name: 'Zenaye', posts_counter: 0)
    post = Post.create!(title: 'Title 1', text: 'First post', comments_counter: 0, likes_counter: 0,
                        author_id: user.id)
    it 'renders a successful response' do
      get user_post_path(user, post)
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end

    it 'renders the correct placeholder text in the response body' do
      get user_post_path(user, post)
      expect(response.body).to include('Posts details')
    end
  end
end
