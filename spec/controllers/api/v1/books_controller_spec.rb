require 'rails_helper'
require 'active_record/errors'
require './spec/support/shared_context/authenticate_user.rb'

describe BooksController, type: :controller do
  describe 'GET #index' do
    context 'without authenticated user' do
      subject!(:http_request) { get :index }

      let!(:books) { create_list(:book, 5) }

      it 'responses with 401 status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when fetching all the books' do
      include_context 'with authenticated user'
      subject!(:http_request) { get :index }

      let!(:books) { create_list(:book, 5) }

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

    context 'without any book' do
      include_context 'with authenticated user'
      subject!(:http_request) { get :index }
    end
  end

  describe 'GET #show' do
    context 'without authenticated user' do
      subject!(:http_request) { get :show, params: { id: book.id } }

      let!(:book) { create(:book) }

      it 'responses with 401 status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when fetching a book' do
      include_context 'with authenticated user'
      subject!(:http_request) { get :show, params: { id: book.id } }

      let!(:book) { create(:book) }

      it 'responses with the book json' do
        expect(response.body).to eq BookSerializer.new(
          book, root: false
        ).to_json
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when fetching an unexisting book' do
      include_context 'with authenticated user'
      subject!(:http_request) { get :show, params: { id: -1 } }

      it 'responses with 404 status: page not found' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
