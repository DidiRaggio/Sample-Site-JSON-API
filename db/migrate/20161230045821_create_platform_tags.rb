class CreatePlatformTags < ActiveRecord::Migration[5.0]
  def change
    create_table :platform_tags do |t|
      t.references :platform, foreign_key: true
      t.references :pitch, foreign_key: true

      t.timestamps
    end
  end
end
