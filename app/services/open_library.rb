class OpenLibrary
  include HTTParty
  base_uri 'https://openlibrary.org'

  def show(isbn)
    # response = self.class.get("/api/books?bibkeys=ISBN:#{isbn}&format=json&jscmd=data")
    response = self.class.get('/api/books', query: { bibkeys: "ISBN:#{isbn}",
                                                     format: 'json',
                                                     jscmd: 'data' })
    response_key = response[response.keys[0]]
    book_details(response_key)
  end

  private

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
