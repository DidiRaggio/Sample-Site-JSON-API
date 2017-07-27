class AddDevIdAndInfluencerIdToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :dev_id, :integer
    add_column :submissions, :influencer_id, :integer
  end
end
