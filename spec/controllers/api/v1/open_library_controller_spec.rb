require 'rails_helper'

describe OpenLibraryController do
  describe '#index' do
    let(:stub_request) do
      WebMock.stub_request(:get, 'https://openlibrary.org/api/books')
             .with(query: { bibkeys: "ISBN:#{isbn}", format: 'json', jscmd: 'data' })
             .to_return(
               status: 200,
               body: request_body,
               headers: { 'Content-Type': 'application/json' }
             )
    end

    let(:bad_stub_request) do
      WebMock.stub_request(:get, 'https://openlibrary.org/api/books')
             .with(query: { bibkeys: 'ISBN:asdbfjsabkm27', format: 'json', jscmd: 'data' })
             .to_return(
               status: 404,
               body: request_body,
               headers: { 'Content-Type': 'application/json' }
             )
    end

    let(:unauthorized_stub_request) do
      WebMock.stub_request(:get, 'https://openlibrary.org/api/books')
             .with(query: { bibkeys: "ISBN:#{isbn}", format: 'json', jscmd: 'data' })
             .to_return(
               status: 401,
               body: request_body,
               headers: { 'Content-Type': 'application/json' }
             )
    end

    let(:isbn) { '0385472579' }
    let(:path) { './spec/support/fixtures/open_library_response' }

    context 'with invalid user' do
      let(:request_body) { File.read("#{path}_unauthorized.json") }

      it 'responds with status code 401 (UNAUTHORIZED)' do
        unauthorized_stub_request
        OpenLibrary.new.show(isbn)
        expect(WebMock).to have_requested(:get, 'https://openlibrary.org/api/books')
          .with(query: { bibkeys: "ISBN:#{isbn}", format: 'json', jscmd: 'data' },
                headers: { 'Content-Type': 'application/json' })
      end
    end

    context 'when requesting for an existent book' do
      include_context 'with authenticated user'
      let(:request_body) { File.read("#{path}_success.json") }

      it 'responds with status code 200 (OK)' do
        stub_request
        OpenLibrary.new.show(isbn)
        expect(WebMock).to have_requested(:get, 'https://openlibrary.org/api/books')
          .with(query: { bibkeys: "ISBN:#{isbn}", format: 'json', jscmd: 'data' },
                headers: { 'Content-Type': 'application/json' })
      end
    end

    context 'when requesting for an unexistent book' do
      include_context 'with authenticated user'
      let(:request_body) { File.read("#{path}_failure.json") }

      it 'responds with status code 404 (PAGE NOT FOUND)' do
        bad_stub_request
        OpenLibrary.new.show('asdbfjsabkm27')
        expect(WebMock).to have_requested(:get, 'https://openlibrary.org/api/books')
          .with(query: { bibkeys: 'ISBN:asdbfjsabkm27', format: 'json', jscmd: 'data' },
                headers: { 'Content-Type': 'application/json' })
      end
    end
  end
end
