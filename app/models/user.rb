class User < ApplicationRecord
  validates :auth_token, uniqueness: true
  before_create :generate_authentication_token!
  has_many :pitches, dependent: :destroy
  has_many :received_submissions, foreign_key: "influencer_id", class_name: "Submission", dependent: :destroy
  has_many :submissions, foreign_key: "dev_id", dependent: :destroy

  has_many :user_genre_tags, :dependent => :destroy
  accepts_nested_attributes_for :user_genre_tags, :allow_destroy =>  true
  has_many :user_genres, through: :user_genre_tags
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_attached_file :picture, 
  styles: { medium: "300x300>", thumb: "100x100>" }, 
  default_url: "/images/:style/missing.png",
  path: "user/:attachment/:id/:style/:filename",
  storage: :s3,
  s3_region: ENV["AWS_REGION"],
  s3_credentials: {
      bucket: ENV['AWS_BUCKET'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], }
  

  # validates_attachment :picture, presence: true 
  
  do_not_validate_attachment_file_type :picture


  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

end

