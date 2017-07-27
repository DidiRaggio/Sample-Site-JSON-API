class CreateSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :submissions do |t|
      t.references :user, foreign_key: true
      t.references :pitch, foreign_key: true
      t.boolean :is_approved, default: false

      t.timestamps
    end
 #    add_column :submissions, :dev_id, :integer
	# add_column :submissions, :influencer_id, :integer
  end
end
