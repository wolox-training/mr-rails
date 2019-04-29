require 'rails_helper'

describe OpenLibrary do
  describe '#show' do
    let(:stub_request) do
      WebMock.stub_request(:get, 'https://openlibrary.org/api/books')
             .with(query: { bibkeys: "ISBN:#{isbn}", format: 'json', jscmd: 'data' })
             .to_return(
               status: 200,
               body: request_body,
               headers: { 'Content-Type': 'application/json' }
             )
    end
    let(:path) { './spec/support/fixtures/open_library_response_' }

    context 'with valid ISBN' do
      let(:request_body) { File.read("#{path}success.json") }
      let(:isbn) { '0385472579' }

      it 'responds with the book details' do
        stub_request
        described_class.new.show(isbn)
        expect(WebMock).to have_requested(:get, 'https://openlibrary.org/api/books')
          .with(query: { bibkeys: "ISBN:#{isbn}", format: 'json', jscmd: 'data' },
                headers: { 'Content-Type': 'application/json' })
      end
    end

    context 'with invalid ISBN' do
      let(:request_body) { File.read("#{path}failure.json") }
      let(:isbn) { 'dfhbasdfbsh' }

      it 'responds with empty body' do
        stub_request
        described_class.new.show(isbn)
        expect(WebMock).to have_requested(:get, 'https://openlibrary.org/api/books')
          .with(query: { bibkeys: "ISBN:#{isbn}", format: 'json', jscmd: 'data' },
                headers: { 'Content-Type': 'application/json' })
      end
    end
  end
end
