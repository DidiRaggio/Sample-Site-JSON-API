class UserGenreTag < ApplicationRecord
  belongs_to :user
  belongs_to :user_genre
  validates :user_genre_id, :user_id, presence: true
end
