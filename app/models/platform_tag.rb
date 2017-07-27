class PlatformTag < ApplicationRecord
  belongs_to :platform
  belongs_to :pitch
  validates :platform_id, :pitch_id, presence: true
end
