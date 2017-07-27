class CreateUserGenreTags < ActiveRecord::Migration[5.0]
  def change
    create_table :user_genre_tags do |t|
      t.references :user, foreign_key: true
      t.references :user_genre, foreign_key: true

      t.timestamps
    end
  end
end
