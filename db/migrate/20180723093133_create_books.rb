class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :price
      t.string :isbn
      t.references :publisher, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :books, :isbn, unique: true
  end
end
