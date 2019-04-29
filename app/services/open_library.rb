class OpenLibrary
  include HTTParty
  base_uri 'https://openlibrary.org'

  def show(isbn)
    response = generate_response(isbn)
    if !response.parsed_response.empty?
      response_key = response[response.keys.first]
      book_details(response_key)
    else
      response.parsed_response
    end
  end

  private

  def generate_response(isbn)
    self.class.get('/api/books',
                   query: { bibkeys: "ISBN:#{isbn}", format: 'json', jscmd: 'data' },
                   headers: { 'Content-Type': 'application/json' })
  end

  def book_details(response_key)
    {
      isbn: response_key['identifiers']['isbn_10'][0],
      title: response_key['title'],
      subtitle: response_key['subtitle'],
      number_of_pages: response_key['number_of_pages'].to_s,
      authors: response_key['authors'][0]['name']
    }
  end
end
