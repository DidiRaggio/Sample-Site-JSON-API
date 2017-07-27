class Pitch < ApplicationRecord
  validates :title, :body, :expected_release_date, :user_id, presence: true, allows_blank: false
  validate :expected_release_date_cannot_be_in_the_past#, :user_is_not_influencer
  # validate :body_must_be_text
  belongs_to :user
  delegate :email, to: :user
  has_many :submissions, :dependent => :destroy


  has_many :genre_tags, :dependent => :destroy
  accepts_nested_attributes_for :genre_tags, :allow_destroy =>  true
  has_many :genres, through: :genre_tags
  
  has_many :platform_tags, :dependent => :destroy
  accepts_nested_attributes_for :platform_tags, :allow_destroy =>  true
  has_many :platforms, through: :platform_tags

  scope :filter_by_title, lambda { |keyword|
    where("lower(title) LIKE ?", "%#{keyword.downcase}%" ) 
  }

  scope :filter_by_website, lambda { |website|
    where("lower(website) LIKE ?", "%#{website.downcase}%" ) 
  }

  scope :above_or_equal_to_expected_release_date, lambda { |expected_release_date| 
    where("expected_release_date >= ?", expected_release_date)
  }

  scope :recent, -> {
    order(:updated_at)
  }

  #SEARCHES BY WORD
  scope :filter_by_genre, lambda { |genre_keyword|
    joins(:genres).where( "name like ?", "%#{genre_keyword.downcase}%" )
  }
  #SEARCHES FULL NAME
  scope :filter_by_genre_name, lambda { |genre_name|
    joins(:genres).where(genres: { name: genre_name } )
  }

  scope :filter_by_genre_id, lambda { |genre_id|
    joins(:genres).where(genres: { id: genre_id } )
  }
  # Pitch.joins(:genres).where(genres: { id: 1 } )


  #SEARCHES BY WORD
  scope :filter_by_platform, lambda { |platform_keyword|
    joins(:platforms).where( "name like ?", "%#{platform_keyword.downcase}%" )
  }
  #SEARCHES FULL NAME
  scope :filter_by_platform_name, lambda { |platform_name|
    joins(:platforms).where(platforms: { name: "%#{platform_name.downcase}%"} )
  }

  scope :filter_by_platform_id, lambda { |platform_id|
    joins(:platforms).where(platforms: { id: platform_id } )
  }
  # Pitch.joins(:genres).where(genres: { id: 1 } )


  def expected_release_date_cannot_be_in_the_past
    if expected_release_date.present? && expected_release_date < Date.today
      errors.add(:expected_release_date, "can't be in the past")
    end
  end 

#DIDI CHECK IF THIS SHOULD BE IN THE MODEL OR CONTOLLER
  # def user_is_not_influencer
  #   if self.user.is_dev == false
  #     errors.add(:pitch, "can not be created by influencer")
  #   end
  # end
  # def body_must_be_text
  #   unless (body.class == String)#body.is_a? String
  #     errors.add(:body, "#{body.class}")
  #   end
  # end

  def self.search(params = {})
    pitches = params[:pitch_ids].present? ? Pitch.find(params[:pitch_ids]) : Pitch.all

    pitches = pitches.filter_by_title(params[:keyword]) if params[:keyword]
    pitches = pitches.filter_by_website(params[:website]) if params[:website]
    pitches = pitches.above_or_equal_to_expected_release_date(params[:expected_release_date]) if params[:expected_release_date]
    pitches = pitches.filter_by_genre(params[:genre_keyword]) if params[:genre_keyword]
    pitches = pitches.filter_by_genre_name(params[:genre_name]) if params[:genre_name]
    pitches = pitches.filter_by_genre_id(params[:genre_id]) if params[:genre_id]
    pitches = pitches.filter_by_platform(params[:platform_keyword]) if params[:platform_keyword]
    pitches = pitches.filter_by_platform_name(params[:platform_name]) if params[:platform_name]
    pitches = pitches.filter_by_platform_id(params[:platform_id]) if params[:platform_id]
    pitches = pitches.recent(params[:recent]) if params[:recent].present?

    pitches
  end

end

