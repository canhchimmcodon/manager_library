class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.date :issued_date
      t.date :expired_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
