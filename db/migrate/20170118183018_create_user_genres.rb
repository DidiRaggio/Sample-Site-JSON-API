class CreateUserGenres < ActiveRecord::Migration[5.0]
  def change
    create_table :user_genres do |t|
      t.string :name, default: ""

      t.timestamps
    end
  end
end
