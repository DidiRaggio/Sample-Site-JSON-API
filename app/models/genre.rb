class Genre < ApplicationRecord
  validates :name, presence: true

  has_many :genre_tags, :dependent => :destroy
  accepts_nested_attributes_for :genre_tags, :allow_destroy =>  true
  has_many :pitches, through: :genre_tags

end
