require 'rails_helper'

describe RentsController, type: :controller do
  describe 'GET #index' do
    context 'without authenticated user' do
      subject!(:http_request) { get :index }

      let!(:rents) { create_list(:rent, 5) }

      it 'responds with status 401 (UNAUTHORIZED)' do
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
      it 'responds with status 401 (UNAUTHORIZED)' do
        post :create, params: FactoryBot.attributes_for(:rent)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with omitted parameters' do
      include_context 'with authenticated user'
      it 'responds to no parameters with status 400 (BAD REQUEST)' do
        no_parameters = {}
        expect { post :create, params: no_parameters }.to raise_error(ActionController::ParameterMissing, 'param is missing or the value is empty: rent')
      end
    end

    context 'with bad parameter' do
      include_context 'with authenticated user'
      it 'responds to bad parameters with status 400 (BAD REQUEST)' do
        bad_parameter = FactoryBot.create(:rent).attributes
        bad_parameter['book_id'] = -1
        expect { post :create, params: { rent: bad_parameter } }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when creation was succesful' do
      include_context 'with authenticated user'
      it 'responds with status 200 (OK)' do
        post :create, params: { rent: FactoryBot.create(:rent).attributes }
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
