Podcast Press
=============

You've mixed down your podcast, but you're not done. Podcast Press handles all the busywork needed to take your audio from a shivering mp3 file to a awe-inspiring episode:

  * Rename the file according to your convention
  * Tag the file with id3 tags for iTunes and other audio players
  * Embed your artwork into the file
  * _Planned_ - Upload your file to a host of your choice (e.g. S3, Dropbox)


**Development Status:** _Barely Started / Not Ready for Use_


Usage
-----

```ruby
episode = PodcastPress.press!('file_path', {
  title: '001: Getting Serious'
  episode_number: 1
  artwork: 'artwork_1200x1200.jpg'
  filename: "My Podcast 001 - Getting Serious.mp3"
})

episode.size     # => 1234567
episode.runtime  # => "54:08"
episode.url      # => "http://dl.dropbox.com/234jsdkfdjsf/my-podcast-001-getting-serious-001.mp3"
```