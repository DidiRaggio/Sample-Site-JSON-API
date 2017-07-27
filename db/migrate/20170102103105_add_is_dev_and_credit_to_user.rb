class AddIsDevAndCreditToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_dev, :boolean, default: true
    add_column :users, :credit, :integer, default: 0
  end
end
