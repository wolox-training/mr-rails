class CreateRents < ActiveRecord::Migration[5.2]
  def change
    create_table :rents do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.date :rent_start, :null => false
      t.date :rent_end, :null => false

      t.timestamps
    end
  end
end
