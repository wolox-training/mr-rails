class BooksSerializer < ActiveModel::Serializer
  atributes :genre, :author, :image, :title, :editor, :year
end
