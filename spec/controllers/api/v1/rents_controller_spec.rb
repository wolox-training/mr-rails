require 'rails_helper'

describe RentsController do
  describe 'GET #index' do
    context 'without authenticated user' do
      subject!(:http_request) { get :index }

      it 'responds with unauthorized status code' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when fetching all the rents' do
      include_context 'with authenticated user'
      subject!(:http_request) { get :index }

      let!(:rents) { create_list(:rent, 5) }

      it 'responds with the books JSON' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          rents, each_serializer: RentSerializer
        ).to_json
        expect(response.body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'without any rent' do
      include_context 'with authenticated user'
      subject!(:http_request) { get :index }

      it 'responds with an empty body' do
        expect(JSON.parse(response.body)['page']).to be_empty
      end

      it 'responds with status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create' do
    context 'without authenticated user' do
      before { post :create, params: attributes_for(:rent) }

      it 'responds with unauthorized status code' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with empty parameters' do
      include_context 'with authenticated user'
      it 'raise ParameterMissing error' do
        no_parameters = {}
        error_msg = 'param is missing or the value is empty: rent'
        expect { post :create, params: no_parameters }
          .to raise_error(ActionController::ParameterMissing, error_msg)
      end
    end

    context 'with an unexistent book' do
      include_context 'with authenticated user'

      let(:bad_parameters) { attributes_for(:rent, user_id: current_user.id, book_id: nil) }

      it 'responds to bad parameters with status 400 (BAD REQUEST)' do
        expect { post :create, params: { rent: bad_parameters } }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'with an unexistent user' do
      include_context 'with authenticated user'

      let(:bad_parameters) { attributes_for(:rent, user_id: -1, book_id: create(:book).id) }

      before { post :create, params: { rent: bad_parameters } }

      it 'responds to bad parameters with status 401 (UNAUTHORIZED)' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when creation was succesful' do
      include_context 'with authenticated user'

      subject!(:http_request) do
        post :create, params:
        { rent: attributes_for(:rent, user_id: current_user.id, book_id: book_id) }
      end

      let(:book_id) { create(:book).id }

      it 'responds with status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
