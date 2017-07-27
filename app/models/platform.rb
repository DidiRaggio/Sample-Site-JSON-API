class Platform < ApplicationRecord
  validates :name, presence: true

  has_many :platform_tags, :dependent => :destroy
  accepts_nested_attributes_for :platform_tags, :allow_destroy =>  true
  has_many :pitches, through: :platform_tags

end
