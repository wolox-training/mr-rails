require 'rails_helper'

describe OpenLibrary, type: :service do
  describe '#show' do
    let(:stub_request) do
      WebMock.stub_request(:get, 'https://openlibrary.org/api/books')
             .with(query: { bibkeys: 'ISBN:0385472579', format: 'json', jscmd: 'data' })
             .to_return(
               status: 200,
               body: File.read('./spec/support/fixtures/open_library_response_success.json'),
               headers: { 'Content-Type': 'application/json' }
             )
    end

    let(:failed_stub_request) do
      WebMock.stub_request(:get, 'https://openlibrary.org/api/books')
             .with(query: { bibkeys: 'ISBN:0385472579', format: 'json', jscmd: 'data' })
             .to_return(
               status: 401,
               body: File.read('./spec/support/fixtures/open_library_response_unauthorized.json'),
               headers: { 'Content-Type': 'application/json' }
             )
    end

    context 'with authenticated user' do
      it 'responds with status 200' do
        stub_request
        OpenLibrary.new.show('0385472579')
        expect(WebMock).to have_requested(:get, 'https://openlibrary.org/api/books')
          .with(query: { bibkeys: 'ISBN:0385472579', format: 'json', jscmd: 'data' },
                headers: { 'Content-Type': 'application/json' })
      end
    end

    context 'without authenticated user' do
      it 'responds with status 401' do
        failed_stub_request
        OpenLibrary.new.show('0385472579')
        expect(WebMock).to have_requested(:get, 'https://openlibrary.org/api/books')
          .with(query: { bibkeys: 'ISBN:0385472579', format: 'json', jscmd: 'data' },
                headers: { 'Content-Type': 'application/json' })
      end
    end
  end
end
