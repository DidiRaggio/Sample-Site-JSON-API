FactoryGirl.define do
  factory :pitch do
    title { FFaker::Lorem.sentence }
    body {  FFaker::Lorem.paragraph }
    video {  FFaker::Youtube.url}
    expected_release_date { FFaker::Time.between(Time.now, 2.days.from_now)}
    website { FFaker::Internet.http_url }
    user
    after :create do |p|
    	4.times do
    		p.genres << FactoryGirl.create(:genre)
    	end
    	2.times do
    		p.platforms << FactoryGirl.create(:platform)
    	end
    end
  end
end
