require 'rails_helper'

describe BooksController, type: :controller do
  describe 'GET #index' do
    context 'without authenticated user' do
      subject!(:http_request) { get :index }

      let!(:books) { create_list(:book, 5) }

      it 'responds with status 401 (UNAUTHORIZED)' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when fetching all the books' do
      include_context 'with authenticated user'
      subject!(:http_request) { get :index }

      let!(:books) { create_list(:book, 5) }

      it 'responds with the books JSON' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          books, each_serializer: BookSerializer
        ).to_json
        expect(response.body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'without any book' do
      include_context 'with authenticated user'
      subject!(:http_request) { get :index }

      it 'responds with status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end

      it 'responds with an empty body' do
        expect(JSON.parse(response.body)['page']).to be_empty
      end
    end
  end

  describe 'GET #show' do
    context 'without authenticated user' do
      subject!(:http_request) { get :show, params: { id: book.id } }

      let!(:book) { create(:book) }

      it 'responds with status 401 (UNAUTHORIZED)' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when fetching a book' do
      include_context 'with authenticated user'
      subject!(:http_request) { get :show, params: { id: book.id } }

      let!(:book) { create(:book) }

      it 'resonds with the book json' do
        expect(response.body).to eq BookSerializer.new(book).to_json
      end

      it 'responds with status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when fetching an unexisting book' do
      include_context 'with authenticated user'
      subject!(:http_request) { get :show, params: { id: -1 } }

      it 'responds with status 404 (PAGE NOT FOUND)' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
