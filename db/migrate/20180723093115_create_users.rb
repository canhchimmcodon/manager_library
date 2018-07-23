class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :contact
      t.column :gender, :integer
      t.string :first_name
      t.string :last_name
      t.column :role, :integer, default: 2
      t.column :card_pending, :boolean, default: false

      t.timestamps
    end
  end
end
