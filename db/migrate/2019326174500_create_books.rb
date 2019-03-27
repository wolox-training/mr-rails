class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table(:books) do |t|
      # Required
      t.string :genre, :null => false
      t.string :author, :null => false
      t.string :image, :null => false
      t.string :title, :null => false
      t.string :editor, :null => false
      t.string :year, :null => false
    end
  end
end
