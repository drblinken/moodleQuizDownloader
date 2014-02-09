require 'mechanize'
require_relative '../lib/moodleQuizDownloader/moodle_parser.rb'
include MoodleParser


 def html_dir
    html_dir = File.join(File.dirname(__FILE__),'moodleparsing','testfiles')
 end
