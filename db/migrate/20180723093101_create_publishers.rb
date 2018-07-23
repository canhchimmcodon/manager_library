class CreatePublishers < ActiveRecord::Migration[5.2]
  def change
    create_table :publishers do |t|
      t.string :publisher
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
