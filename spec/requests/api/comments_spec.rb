require 'swagger_helper'

RSpec.describe 'api/comments', type: :request do
  describe 'Comments' do
    path '/api/v1/comments' do
      post 'Create a comment' do
        tags 'Comments'
        consumes 'application/json'
        parameter name: :comment, in: :body, schema: {
          type: :object,
          properties: {
            author_id: { type: :integer },
            post_id: { type: :integer },
            text: { type: :string }
          },
          required: %w[author_id post_id text]
        }

        response '201', 'comment created' do
          let(:comment) { { author_id: 1, post_id: 1, text: 'text' } }
          run_test!
        end

        response '422', 'invalid request' do
          let(:comment) { { text: 'text' } }
          run_test!
        end
      end
    end

    path '/api/v1/comments/{id}' do
      get 'Retrieves a comment' do
        tags 'Comments'
        produces 'application/json', 'application/xml'
        parameter name: :id, in: :path, type: :string

        response '200', 'comment created' do
          schema type: :object,
                 properties: {
                   id: { type: :integer },
                   author_id: { type: :string },
                   post_id: { type: :string },
                   text: { type: :string }
                 },
                 required: %w[id post_id text]

          let(:id) { Comment.create(author_id: 'id', post_id: 'id', text: 'text').id }
          run_test!
        end

        response '404', 'comment not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end
    end
  end
end
