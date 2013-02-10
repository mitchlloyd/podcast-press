Podcast Press
=============

You've mixed down your podcast, but you're not done. This library automates all the busywork needed to take your audio from a shivering mp3 file to a awe-inspiring episode:

  * Rename the file according to your convention
  * Tag the file with id3 tags for iTunes and other audio players
  * Embed your artwork into the file
  * Get size and runtime values for your RSS feed
  * Upload your file to Amazon's S3


Using as a Command Line Tool
----------------------------

Setup a config file called podcast_press_config.rb

```ruby
set podcast_title: 'Eric & Mitch Explain'
set artist: "Eric & Mitch"
set artwork: "./source/images/eme-artwork.jpg"
set date: Time.now
set title: "Eric & Mitch Explain ##{get :episode_number}: #{get :title}"
set filename: "eric&mitch-#{get :episode_number, min_digits: 3}.mp3"
set clear: true
set s3_bucket: "my-s3-bucket-name"
```

Then run the command line utility:

`ppress podcast-mixdown.mp3`

After you enter the episode number (2) and the title (Techno Utopianism) you'll get the following:

* ID3 title tag: "Eric & Mitch Explain #2: Techno Utopianism"
* ID3 artist tag: "Eric & Mitch"
* ID3 album tag: "Eric & Mitch Explain"
* ID3 genre tag: "Podcast"
* ID3 date/year tag: 2012
* ID3 track number: 2
* Embedded artwork file "eme-artwork.jpg"
* File renamed to "eric&mitch-002.mp3"
* Any previsously set tags cleared (due to the `clear: true` setting)
* File uploaded to S3 and made publicly readable


Using as a Library
------------------

```ruby
episode = PodcastPress.press!('file_path', {
  title: "001: Getting Serious"
  artist: "Mitch"
  episode_number: 1
  artwork: "artwork_1200x1200.jpg"
  filename: "My Podcast 001 - Getting Serious.mp3"
})

# Calling press! above does the following:
#   * Adds an id3 title tag with "001: Getting Serious"
#   * Adds an id3 artist tag with "Mitch"
#   * Adds an id3 tag with track number set to 1
#   * Embeds the artwork in the mp3 file
#   * Renames the file to "My Podcast 001 - Getting Serious.mp3"

episode.size     # => 1234567
episode.runtime  # => "00:54:08"
```
