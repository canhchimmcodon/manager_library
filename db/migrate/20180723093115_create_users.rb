class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :contact
      t.column :gender, :integer
      t.string :first_name
      t.string :last_name
      t.column :terms_of_service, :boolean
      t.column :role, :integer, default: 2

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
