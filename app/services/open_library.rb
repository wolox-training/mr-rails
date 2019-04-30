class OpenLibrary
  include HTTParty
  base_uri 'https://openlibrary.org'

  def show(isbn)
    response = generate_response(isbn)
    process_response(response)
  end

  private

  def generate_response(isbn)
    self.class.get('/api/books',
                   query: { bibkeys: "ISBN:#{isbn}", format: 'json', jscmd: 'data' },
                   headers: { 'Content-Type': 'application/json' })
  end

  def process_response(response)
    case response.code_type.to_s
    when 'Net::HTTPOK'
      if !response.parsed_response.empty?
        book_details(response[response.keys.first])
      else
        response.parsed_response
      end
    when 'Net::HTTPUnauthorized'
      response.parsed_response
    end
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
