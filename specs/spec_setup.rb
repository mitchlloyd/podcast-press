require 'minitest/autorun'
require 'minitest/reporters'
require 'taglib'
require_relative './spec_helpers'
require_relative '../lib/podcast_press'

MiniTest::Reporters.use!

SANDBOX = './specs/sandbox'
FILENAME = './specs/sandbox/test_file.mp3'
MP3_FIXTURE = './specs/fixtures/sine.mp3'
