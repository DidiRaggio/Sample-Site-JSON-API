class GenreTag < ApplicationRecord
  belongs_to :genre
  belongs_to :pitch
  validates :genre_id, :pitch_id, presence: true
end
