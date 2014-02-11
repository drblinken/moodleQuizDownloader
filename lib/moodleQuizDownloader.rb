require_relative "moodleQuizDownloader/version.rb"
require_relative "moodleQuizDownloader/option_handler.rb"
require_relative "moodleQuizDownloader/quiz_downloader.rb"
require_relative "moodleQuizDownloader/attempt_selector.rb"

module MoodleQuizDownloader
  def run_script(arguments)
    options = OptionHandler.new(arguments).parse
    if options.usage
      puts options.usage
      exit
    end
    QuizDownloader.new(options).run
  end
end


