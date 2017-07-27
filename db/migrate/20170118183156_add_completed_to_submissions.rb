class AddCompletedToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :is_complete, :boolean, default: false
  end
end
