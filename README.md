# MoodleQuizDownloader

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'moodleQuizDownloader'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install moodleQuizDownloader

## Usage

for example, run

    $ moodleQuizDownloader.rb -e 4711 -u drblinken -s http://moodle2.htw-berlin.de/ -p geheim --verbose

to see a list of all attempts in exam 4711 on the specified server,
and

    $ moodleQuizDownloader.rb -e 4711 -u drblinken -s http://moodle2.htw-berlin.de/ -p geheim --verbose download

to download them.

to see all options:

    $ moodleQuizDownloader.rb help

## try it out in irb

e.g.:

     irb
     load 'lib/moodleQuizDownloader.rb'

     arguments = "-o /Users/kleinen/Documents/ss2013/exam-     ckup/info3/pz1/exam_a/raw -e 23843".split(" ")
     options = OptionHandler.new(arguments).parse
     q = QuizDownloader.new
     agent = Mechanize.new
     q.smoketest(options.moodle_server)
     q.attemptlist(options,agent)
     page = q.smoketest(options.moodle_server)
     username_input = page.search('#username')

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
