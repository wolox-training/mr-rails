require 'rails_helper'

describe BookSuggestionsController do
  describe 'POST #create' do
    context 'with invalid user reference' do
      include_context 'with authenticated user'

      let(:bad_parameters) { attributes_for(:book_suggestion, user_id: -1) }

      before { post :create, params: { book_suggestion: bad_parameters } }

      it 'responds with status 401 (UNAUTHORIZED)' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with empty parameters' do
      include_context 'with authenticated user'

      it 'raise ParameterMissing error' do
        no_parameters = {}
        error_msg = 'param is missing or the value is empty: book_suggestion'
        expect { post :create, params: no_parameters }
          .to raise_error(ActionController::ParameterMissing, error_msg)
      end
    end

    context 'with invalid author' do
      include_context 'with authenticated user'

      let(:bad_parameters) { attributes_for(:book_suggestion, author: nil) }

      it 'responds with status 400 (BAD REQUEST)' do
        expect { post :create, params: { book_suggestion: bad_parameters } }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'with invalid title' do
      include_context 'with authenticated user'

      let(:bad_parameters) { attributes_for(:book_suggestion, title: nil) }

      it 'responds with status 400 (BAD REQUEST)' do
        expect { post :create, params: { book_suggestion: bad_parameters } }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'with invalid link' do
      include_context 'with authenticated user'

      let(:bad_parameters) { attributes_for(:book_suggestion, link: nil) }

      it 'responds with status 400 (BAD REQUEST)' do
        expect { post :create, params: { book_suggestion: bad_parameters } }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'with invalid editor' do
      include_context 'with authenticated user'

      let(:bad_parameters) { attributes_for(:book_suggestion, editor: nil) }

      it 'responds with status 400 (BAD REQUEST)' do
        expect { post :create, params: { book_suggestion: bad_parameters } }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'with invalid year' do
      include_context 'with authenticated user'

      let(:bad_parameters) { attributes_for(:book_suggestion, year: nil) }

      it 'responds with status 400 (BAD REQUEST)' do
        expect { post :create, params: { book_suggestion: bad_parameters } }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'without synopsis' do
      include_context 'with authenticated user'
      let(:nil_synopsis_book_suggestion) { attributes_for(:book_suggestion, synopsis: nil) }

      before { post :create, params: { book_suggestion: nil_synopsis_book_suggestion } }

      it 'responds with status 201 (CREATED)' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'without price' do
      include_context 'with authenticated user'
      let(:nil_synopsis_book_suggestion) { attributes_for(:book_suggestion, price: nil) }

      before { post :create, params: { book_suggestion: nil_synopsis_book_suggestion } }

      it 'responds with status 201 (CREATED)' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with anonymous user' do
      let(:no_user_book_suggestion) { attributes_for(:book_suggestion) }

      before { post :create, params: { book_suggestion: no_user_book_suggestion } }

      it 'responds with status 201 (CREATED)' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with null user reference' do
      include_context 'with authenticated user'
      let(:nil_user_book_suggestion) { attributes_for(:book_suggestion, user_id: nil) }

      before { post :create, params: { book_suggestion: nil_user_book_suggestion } }

      it 'responds with status 201 (CREATED)' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with existent user reference' do
      include_context 'with authenticated user'
      let(:user_book_suggestion) { attributes_for(:book_suggestion, user_id: current_user.id) }

      before { post :create, params: { book_suggestion: user_book_suggestion } }

      it 'responds with status 201 (CREATED)' do
        expect(response).to have_http_status(:created)
      end
    end
  end
end
