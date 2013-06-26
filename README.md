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
    ruby lib/moodleQuizDownloader.rb -e 4711 -u drblinken -s http://moodle2.htw-berlin.de/ -p geheim --verbose
to see a list of all attempts in exam 4711 on the specified server,
and
    ruby lib/moodleQuizDownloader.rb -e 4711 -u drblinken -s http://moodle2.htw-berlin.de/ -p geheim --verbose download

to download them.

to see all options:
    ruby lib/moodleQuizDownloader.rb help

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
