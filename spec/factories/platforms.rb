FactoryGirl.define do
  factory :platform do
    name { FFaker::Lorem.sentence }
  end
end
