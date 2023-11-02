require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns a successful response' do
      get users_path
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'renders the correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('All users')
    end
  end

  describe 'GET /show' do
    user = User.create!(name: 'Zenaye', posts_counter: 0)
    it 'renders a successful response' do
      get user_url(user)
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get user_url(user)
      expect(response).to render_template(:show)
    end

    it 'renders the correct placeholder text in the response body' do
      get user_url(user)
      expect(response.body).to include('All posts by a user')
    end
  end
end
