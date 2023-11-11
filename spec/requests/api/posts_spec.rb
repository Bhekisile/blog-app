require 'swagger_helper'

RSpec.describe 'api/posts', type: :request do
describe 'Posts' do

  path '/api/v1/posts' do

    post 'Create a post' do
      tags 'Posts'
      consumes 'application/json'
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          text: { type: :string }
        },
        required: [ 'title', 'text' ]
      }

      let!(:post) { { title: 'Test title', text: 'Test text'} }
      let(:id) { post.id }
      response '201', 'post created' do
        run_test!
      end

      response '422', 'invalid request' do
        let(:post) { Post.create(title: 'Test title', text: 'Test text') }
        run_test!
      end
    end
  end

  path '/api/v1/posts/{id}' do

    get 'Retrieves a post' do
      tags 'Posts', 'Post_from_user'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      let!(:post) { {title: 'Test title', text: 'Test text'} }
      let(:post_id) { post.id }
      response '200', 'post created' do
        schema type: :object,
          properties: {
            id: { type: :string },
          title: { type: :string },
          text: { type: :string }
        },
        required: ['title', 'text' ]

        run_test!
      end

      response '404', 'post not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/excel' }
        run_test!
      end
    end
  end
end

end