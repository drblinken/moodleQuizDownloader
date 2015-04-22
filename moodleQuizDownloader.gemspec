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


  spec.add_dependency "asciify", '~> 0.1.0'
  spec.add_dependency "iconv",'~> 1.0', '>= 1.0.4' #this is a dependency of asciify
  spec.add_dependency 'mechanize','~> 2.7', '>= 2.7.3'
  spec.add_dependency 'pdfkit','~> 0.6.2'
  spec.add_dependency 'wkhtmltopdf-binary','~> 0.9'
  spec.add_dependency 'highline','~> 1.6', '>= 1.6.21' # prompt for password


  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake",'~> 0'
  spec.add_development_dependency "rspec",'~> 0'
  spec.add_development_dependency "faker",'~> 0'

end
