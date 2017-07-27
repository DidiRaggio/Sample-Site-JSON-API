FactoryGirl.define do
  factory :submission do
 
  	dev { FactoryGirl.create(:user) }
  	influencer {FactoryGirl.create(:user) }
    pitch
    is_approved "false"


  end
end
