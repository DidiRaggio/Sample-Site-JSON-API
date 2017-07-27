class UserGenre < ApplicationRecord
  validates :name, presence: true

  has_many :user_genre_tags, :dependent => :destroy
  accepts_nested_attributes_for :user_genre_tags, :allow_destroy =>  true
  has_many :users, through: :user_genre_tags

end
