class CreatePitches < ActiveRecord::Migration[5.0]
  def change
    create_table :pitches do |t|
      t.string :title, default: ""
      t.text :body, default: ""
      t.string :video, default: ""
      t.datetime :expected_release_date
      t.string :website, default: ""
      t.integer :user_id

      t.timestamps
    end
    add_index :pitches, :user_id
  end
end
