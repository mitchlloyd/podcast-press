Podcast Press
=============

You've mixed down your podcast, but you're not done. This library helps you automate all the busywork needed to take your audio from a shivering mp3 file to a awe-inspiring episode:

  * Rename the file according to your convention
  * Tag the file with id3 tags for iTunes and other audio players
  * Embed your artwork into the file
  * Get size and runtime values for your RSS feed
  * _Planned_ - Upload your file to a host of your choice (e.g. S3, Dropbox)


**Development Status:** _Partially usable but incomplete_


Usage
-----

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
episode.url      # => (planned) "http://dl.dropbox.com/234jsdkfdjsf/my-podcast-001-getting-serious-001.mp3"
```