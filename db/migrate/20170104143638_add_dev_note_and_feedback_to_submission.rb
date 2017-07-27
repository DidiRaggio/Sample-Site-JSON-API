class AddDevNoteAndFeedbackToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :dev_note, :text, default: ""
    add_column :submissions, :feedback, :text, default: ""
  end
end
