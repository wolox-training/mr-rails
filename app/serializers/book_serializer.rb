class BookSerializer < ActiveModel::Serializer
  attributes :genre, :author, :image, :title, :editor, :year
end
