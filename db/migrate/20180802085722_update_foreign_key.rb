class UpdateForeignKey < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key "author_books", "authors"
    remove_foreign_key "author_books", "books"
    remove_foreign_key "books", "categories"
    remove_foreign_key "books", "publishers"
    remove_foreign_key "cards", "users"
    remove_foreign_key "comments", "books"
    remove_foreign_key "comments", "users"
    remove_foreign_key "copies", "books"
    remove_foreign_key "notifications", "users"
    remove_foreign_key "registered_copies", "cards"
    remove_foreign_key "registered_copies", "copies"

    add_foreign_key "author_books", "authors", on_delete: :cascade
    add_foreign_key "author_books", "books", on_delete: :cascade
    add_foreign_key "books", "categories", on_delete: :cascade
    add_foreign_key "books", "publishers", on_delete: :cascade
    add_foreign_key "cards", "users", on_delete: :cascade
    add_foreign_key "comments", "books", on_delete: :cascade
    add_foreign_key "comments", "users", on_delete: :cascade
    add_foreign_key "copies", "books", on_delete: :cascade
    add_foreign_key "notifications", "users", on_delete: :cascade
    add_foreign_key "registered_copies", "cards", on_delete: :cascade
    add_foreign_key "registered_copies", "copies", on_delete: :cascade

    add_column :books, :summary, :text
  end
end
