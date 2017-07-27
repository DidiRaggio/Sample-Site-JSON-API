class PitchSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :video, :expected_release_date, :website
  has_one :user
  has_many :genres
  has_many :platforms
end
