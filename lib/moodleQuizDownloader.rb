require_relative "moodleQuizDownloader/version.rb"
require_relative "moodleQuizDownloader/option_handler.rb"
require_relative "moodleQuizDownloader/quiz_downloader.rb"
require_relative "moodleQuizDownloader/attempt_selector.rb"

module MoodleQuizDownloader

  def run_script(arguments)
    option_handler = OptionHandler.new(arguments)
    options = option_handler.options
    if options.usage
      puts options.usage
      exit
    end
    options.moodle_password ||= prompt_for_password
    QuizDownloader.new(options).run
  end

  def prompt_for_password(prompt="Enter Password")
    require 'highline/import'
    ask(prompt) {|q| q.echo = false}
  end
end


