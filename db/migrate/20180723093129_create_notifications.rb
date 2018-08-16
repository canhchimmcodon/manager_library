class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.text :content
      t.column :read, :boolean, default: false
      t.references :user, foreign_key: true
      t.belongs_to :notifiable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
