class AddCardActivationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :card_activation_digest, :string
    add_column :users, :card_activated, :boolean, default: false
  end
end
