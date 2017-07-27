class UserSerializer < ActiveModel::Serializer
  # embed :ids
  attributes :id, :email, :created_at, :updated_at, :is_dev, :credit, :auth_token, :picture, :medium_picture, :thumb_picture

  has_many :submissions
  has_many :received_submissions
  has_many :pitches
  has_many :user_genres

  def medium_picture
    object.picture.url(:medium)
  end

  def thumb_picture
    object.picture.url(:thumb)
  end

  def pitches
    customized_pitches = []

    object.pitches.each do |pitch|
      # Assign object attributes (returns a hash)
      # ===========================================================
      custom_pitch = pitch.attributes
      custom_pitch[:genres] = pitch.genres.collect{|proposal| proposal.attributes}#.slice(:id, :name, :updated_at)}
      custom_pitch[:platforms] = pitch.platforms.collect{|proposal| proposal.attributes}
      # ===========================================================
      customized_pitches.push(custom_pitch)
    end

    return customized_pitches
  end

  def submissions
    customized_submissions = []

    object.submissions.each do |submission|
      # Assign object attributes (returns a hash)
      # ===========================================================
      custom_submission = submission.attributes
      custom_submission[:pitch] = submission.pitch#.slice(:id, :name) # get only :id and :name for the project
      custom_submission[:dev] = submission.dev
      custom_submission[:influencer] = submission.influencer
      # ===========================================================
      customized_submissions.push(custom_submission)
    end

    return customized_submissions
  end

  def received_submissions
    customized_received_submissions = []

    object.received_submissions.each do |received_submission|
      # Assign object attributes (returns a hash)
      # ===========================================================
      custom_received_submission = received_submission.attributes
      custom_received_submission[:pitch] = received_submission.pitch#.slice(:id, :name) # get only :id and :name for the project
      custom_received_submission[:dev] = received_submission.dev
      custom_received_submission[:influencer] = received_submission.influencer
      # ===========================================================
      customized_received_submissions.push(custom_received_submission)
    end

    return customized_received_submissions
  end



end