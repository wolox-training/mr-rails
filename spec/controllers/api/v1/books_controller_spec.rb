require 'rails_helper'

RSpec.shared_context 'when authenticated User' do
  let(:user) { create(:user) }

  before do
    request.headers.merge! user.create_new_auth_token
  end
end

describe BooksController, type: :controller do
  include_context 'when authenticated User'

  describe 'GET #index' do
    context 'when fetching all the books' do
      let!(:books) { create_list(:book, 5) }

      before do
        get :index
      end

      it 'responses with the books json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          books, each_serializer: BookSerializer
        ).to_json
        expect(response.body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'when fetching a book' do
      let!(:book) { create(:book) }

      before do
        get :show, params: { id: book.id }
      end

      it 'responses with the book json' do
        expect(response.body).to eq BookSerializer.new(
          book, root: false
        ).to_json
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
