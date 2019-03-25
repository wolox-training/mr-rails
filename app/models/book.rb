class Book < ActiveRecord::Base
  validates :genre, :author, :image, :title, :editor, :year, presence: true
end
