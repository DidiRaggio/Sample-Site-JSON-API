class Submission < ApplicationRecord
  validates :pitch_id, :dev_id, :influencer_id, presence: true
  validate :pitch_user_is_dev, :influencer_is_not_dev
  validate :repeated_pitch_to_influencer, on: [:create]
  belongs_to :dev, class_name: 'User', inverse_of: :submissions
  belongs_to :influencer , class_name: 'User', inverse_of: :submissions
  belongs_to :pitch, inverse_of: :submissions

  def pitch_user_is_dev
  	if pitch.user_id != dev_id
  		self.update_attribute(:dev_id, self.pitch.user_id)
  	end
  end

  def influencer_is_not_dev
  	if influencer.is_dev == true
  		errors.add(:influencer, "must not be a dev")
  	end
  end

  def repeated_pitch_to_influencer
  	influencer_recieved_pitch_ids = []
  	influencer.received_submissions.each { |x| influencer_recieved_pitch_ids << x.pitch_id }
  	if  influencer_recieved_pitch_ids.include? pitch_id
  		errors.add(:pitch_id, "has already been submitted to this influencer")
  	end
  end
end


# User.find(1).pitches.first.submissions.first.influencer.received_submissions.ids
# User.find(1).pitches.first.submissions.first.influencer.received_submissions.each { |x| pitch_ids << x.pitch_id  }