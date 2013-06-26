# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moodleQuizDownloader/version'

Gem::Specification.new do |spec|
  spec.name          = "moodleQuizDownloader"
  spec.version       = MoodleQuizDownloader::VERSION
  spec.authors       = ["Dr Blinken"]
  spec.email         = ["drblinken@gmail.com"]
  spec.description   = %q{Downloads Quizzes from Moodle as PDF}
  spec.summary       = %q{This is a little ruby command line tool that hooks to a moodle server and downloads all attempts for an exam as pdfs.}
  spec.homepage      = "https://github.com/drblinken/moodleQuizDownloader"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]


  spec.add_dependency "asciify"
  spec.add_dependency "iconv" #this is a dependency of asciify
  spec.add_dependency 'mechanize'
  spec.add_dependency 'pdfkit'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

end
