class SubmissionSerializer < ActiveModel::Serializer
  attributes :id, :dev_note, :is_approved, :feedback, :pitch_id, :dev_id, :influencer_id
  has_one :pitch
  has_one :dev
  has_one :influencer
end