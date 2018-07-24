class CreateRegisteredCopies < ActiveRecord::Migration[5.2]
  def change
    create_table :registered_copies do |t|
      t.date :registered_date
      t.date :borrowed_date
      t.date :expected_return_date
      t.column :borrowed, :boolean, default: false
      t.references :copy, foreign_key: true
      t.references :card, foreign_key: true

      t.timestamps
    end
  end
end
