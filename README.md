# MoodleQuizDownloader

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'moodleQuizDownloader'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install moodleQuizDownloader

## What it does

This script downloads all attempts of a moodle quiz and saves them in pdfs named with the student names.
For this it logs into moodle via the http/html web site, goes to the quiz and scrapes all information like student names etc. from the html it finds.

To get started, you first need the moodle id of the quiz you want to download. E.g. if the url shown in the browser was

https://moodle.htw-berlin.de/mod/quiz/report.php?id=4711&mode=overview

If you view the quiz's attempts in the browser,

     4711

is the id.

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
