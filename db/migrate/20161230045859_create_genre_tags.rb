class CreateGenreTags < ActiveRecord::Migration[5.0]
  def change
    create_table :genre_tags do |t|
      t.references :genre, foreign_key: true
      t.references :pitch, foreign_key: true

      t.timestamps
    end
  end
end
