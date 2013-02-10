set podcast_title: 'My Great Podcast'
set artist: "Mr. Gab"
set artwork: "./artwork.jpg"
set clear: true
set date: Time.now
set filename: "#{get :podcast_title} #{get :episode_number, padding: 3} - #{get :episode_title}.mp3"