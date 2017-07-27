UserGenre.create(name: 'youtube')
UserGenre.create(name: 'twitch')

User.create(email: 'first@dev.com', password: 'password', password_confirmation: 'password')
User.create(email: 'second@dev.com', password: 'password', password_confirmation: 'password')
User.create(email: 'third@dev.com', password: 'password', password_confirmation: 'password')
User.create(email: 'first@influencer.com', password: 'password', password_confirmation: 'password', is_dev: false).update_attributes(user_genre_ids: [1,2])
User.create(email: 'second@influencer.com', password: 'password', password_confirmation: 'password', is_dev: false).update_attributes(user_genre_ids: [1,2])



Platform.create(name: 'Steam')
Platform.create(name: 'Xbox')
Platform.create(name: 'PS4')

Genre.create(name: 'FPS')
Genre.create(name: 'JRPG')
Genre.create(name: 'Survival Horror')

Pitch.create(title: "Dev 1's first pitch", body: "blah blah blah", expected_release_date: "2019-04-4", user_id: 1).update_attributes(genre_ids: [3], platform_ids: [2,3])
Pitch.create(title: "Dev 1's second pitch", body: "blah blah blah", expected_release_date: "2019-06-4", user_id: 1).update_attributes(genre_ids: [1,3], platform_ids: [1])
Pitch.create(title: "Dev 1's third pitch", body: "blah blah blah", expected_release_date: "2019-04-7", user_id: 1).update_attributes(genre_ids: [2,1], platform_ids: [1])
Pitch.create(title: "Dev 2's first pitch", body: "blah blah blah", expected_release_date: "2019-04-4", user_id: 2).update_attributes(genre_ids: [1,3], platform_ids: [2])
Pitch.create(title: "Dev 2's second pitch", body: "blah blah blah", expected_release_date: "2019-06-4", user_id: 2).update_attributes(genre_ids: [2], platform_ids: [2])
Pitch.create(title: "Dev 3's first pitch", body: "blah blah blah", expected_release_date: "2019-04-4", user_id: 3).update_attributes(genre_ids: [1,2,3], platform_ids: [1,2,3])

Submission.create(pitch_id: 1, dev_id: 1, influencer_id: 4, dev_note: "submission of dev 1's first pitch to influencer 4")
Submission.create(pitch_id: 2, dev_id: 1, influencer_id: 4, dev_note: "submission of dev 1's second pitch to influencer 4")
Submission.create(pitch_id: 5, dev_id: 2, influencer_id: 4, dev_note: "submission of dev 2's second pitch to influencer 4")
Submission.create(pitch_id: 6, dev_id: 3, influencer_id: 4, dev_note: "submission of dev 3's first pitch to influencer 4")

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')