class CreateCopies < ActiveRecord::Migration[5.2]
  def change
    create_table :copies do |t|
      t.integer :sequence_number
      t.column :status, :integer, default: 0
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
